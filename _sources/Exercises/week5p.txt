
*************************
Week 5 programming: lists
*************************

:Subsite home page: http://bit.ly/focs-aux


A: Head and tail, first and second
==================================

You can get the head and the tail of a list with functions ``hd`` and ``tl``. 

In OCaml/utop, you first have to type ::

    open List;;

to get access to these functions.

You can get the first and the second part of a pair with the functions ``fst`` and ``snd``. *This only works* for 2-tuples (e.g. ``(3, "abc")``), not smaller tuples (like ``()``, ``(2, 3, 4)``, ...) .

.. skip:: big

* Can you find the head and the tail of the :doc:`terms from last week <week4p>`, if they exist?

* Can you find the first and the second component of any pairs in those terms?
  
Check your answers with ``ocaml``/``utop``.

B: Cons exercises
=================

Which of these terms is valid? If it is valid, what is its value, and what is its type?

Check your answers with ``ocaml``/``utop``. I have left room to write below, but this time you cannot click to see the solution.

#. ``3 :: []``

   .. collapse:: .
#. ``3 :: 4 :: []``

   .. collapse:: .
#. ``3 :: [4]``

   .. collapse:: .
#. ``[3] :: []``

   .. collapse:: .
#. ``[3] :: 4``

   .. collapse:: .
#. ``[] :: []``

   .. collapse:: .
#. ``[] :: [[]]``

   .. collapse:: .
#. ``[[]] :: []``

   .. collapse:: .
#. ``[[]] :: [[]]``

   .. collapse:: .
#. ``[] :: [], []``

   .. collapse:: .
#. ``[] :: []; []``

   .. collapse:: .
#. ``[[] :: []; []]``
   
   (Note: this is very different!)

   .. collapse:: .

C: List exercises
=================


https://ocaml.org/learn/tutorials/99problems.html (solutions are provided)

:See also: the assignment_ on Canvas

.. _assignment: https://canvas.bham.ac.uk/courses/15627/assignments/46796


Additional hints given on Canvas:

    Some of the question use the OCaml ``option`` type. This type is used to return a special value (``None``) when a function cannot be computed, instead of throwing an exception. For example, the standard ``hd`` function is::

        let hd = function
          | [] -> failwith "hd"
          | x :: _ -> x

    and has type  ::

        val hd : 'a list -> 'a = <fun>

    If you want to avoid throwing a failure the alternative is this::

        let hd = function
          | [] -> None
          | x :: _ -> Some x

    and has type ::

        val hd : 'a list -> 'a option = <fun>

    For the purpose of this assignment you can ignore the ``option`` type and use ``failwith`` instead of ``None``.

    For a longer discussion of option types read this article: https://blogs.janestreet.com/making-something-out-of-nothing-or-why-none-is-better-than-nan-and-null/ 