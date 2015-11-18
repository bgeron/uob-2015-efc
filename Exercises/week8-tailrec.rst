
.. highlight:: ocaml

**********************
Week 8: tail recursion
**********************

There are three common types of function you can easily make tail-recursive.

#.  As you go through an input list, you generate a list from the right. Example: reverse, because ::
   
        reverse [1; ...] = [...; 1]

#.  As you go through an input list, you generate something else. Example: length, because ::
        
        length [1; ...] = 1 + length [...]

    This works because ``+`` is commutative, associative, and has a unit: ``x + y = y + x`` and ``x + (y + z) = (x + y) + z`` and ``0 + x = x + x + 0``. 

#.  As you go through an input list, you generate a list from the left. Example: duplicates, because ::

        duplicates [1; ...] = [1; 1; ...]

For all cases, we use an *accumulator*, which means a subresult variable. For ``reverse``, the accumulator will be appended to the end; for ``length``, it will be added, and for ``duplicates``, it will be prepended in reverse. The accumulator variable is often spelled ``acc``. 

Let's look at each case again.

.. rubric:: Generate a list from the right

Our specification::

	revap xs acc = rev xs @ acc

Example equations::

	revap [1; 2; 3] [4; 5; 6]
	= [3; 2; 1; 4; 5; 6]
	= revap [2; 3] [1; 4; 5; 6]

	revap [] [4; 5; 6] = rev [] @ [4; 5; 6] = [4; 5; 6]

You can implement ``revap`` tail-recursively yourself from these examples. Note that ::

	revap [1; 2; 3] [] = rev [1; 2; 3]
	
so you can define ``rev`` in terms of ``revap``::

	let rev xs = revap xs []

.. rubric:: Symmetric and commutative operator with a unit, such as +

Our specification::

	length' xs acc = length xs + acc

Example equations::

	length' [1; 2; 3] acc
	= 3 + acc
	= length' [2; 3] (1 + acc)

	length' [] acc
	= 0 + acc
	= acc

You can implement ``length'`` tail-recursively yourself from these examples. Note that ::

	length' [1; 2; 3] 0 = length [1; 2; 3]
	
so you can define ``length`` in terms of ``length'``::

	let length xs = length' xs 0


.. rubric:: Generate a list from the left

This one is a tad more complicated, but very useful in practice. Remember that ``dup [1; 2; 3]`` should be ``[1; 1; 2; 2; 3; 3]``; a simple implementation is::

	let rec dup xs = match xs with
	  | [] -> []
	  | x::xs' -> x :: x :: dup xs' ;;

Our specification::

	dupprep xs acc = (rev acc) @ dup xs

``dupprep`` stands for "duplicate-prepend". **(Note the** ``rev``\ **!)**

Example equations::

	dupprep [1; 2; 3] [4; 5; 6]
	= [6; 5; 4; 1; 1; 2; 2; 3; 3]
	= dupprep [2; 3] [1; 1; 4; 5; 6]

	dupprep [] [4; 5; 6] = [6; 5; 4] = rev [4; 5; 6]

You can implement ``dupprep`` tail-recursively yourself from these examples. Note that ::

	dupprep [1; 2; 3] [] = dup [1; 2; 3]
	
so you can define ``dup`` in terms of ``dupprep``::

	let dup xs = dupprep xs []


.. note:: Sometimes, the normal functions don't have one list argument, but many functions of various types. That doesn't matter. You can use these schemes to make your tail recursion, no matter the number of arguments or their types. For instance, the tail-recursive version of ``sim_dif`` takes ``xs``, ``ys``, *and* an accumulator parameter. (See the `sample solution for 7-3a`_.)

.. _sample solution for 7-3a: https://github.com/Duta/focs-2015-16/blob/master/solutions/week-7/exercise-3a/wk7ex3a.ml


Examples
========

We have three schemes:

a. Generating a list from the right
b. Generating a sum starting from 0, or a product starting from 1, or ...
c. Generating a list from the left


Scheme A makes these functions tail-recursive: ``setify``, ``rev``, ``mklist`` (if you reorder the output), ``dif`` (if you reorder the output)

Scheme B makes these functions tail-recursive: ``sum``, ``product``, ``length``, number of elements matching something, product of all elements matching something

Scheme C makes these functions tail-recursive: ``append``, ``dif``, ``sim_dif`` (the fast version), ``zip``

Appendix
========


Find all the functions in the OCaml standard library here:

http://caml.inria.fr/pub/docs/manual-ocaml/stdlib.html

(go to www.ocaml.org → manual → Part IV → the standard library.)