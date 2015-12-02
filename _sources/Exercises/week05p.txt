
*************************
Week 5 programming: lists
*************************

.. highlight:: ocaml
.. default-role:: code

:Subsite home page: http://bit.ly/focs-aux


A: Head and tail, first and second
==================================

You can get the head and the tail of a list with functions ``hd`` and ``tl``. 

In OCaml/utop, you first have to type ::

    open List;;

to get access to these functions.

You can get the first and the second part of a pair with the functions ``fst`` and ``snd``. *This only works* for 2-tuples (e.g. ``(3, "abc")``), not smaller tuples (like ``()``, ``(2, 3, 4)``, ...) .

.. skip:: big

* Can you find the head and the tail of the :doc:`terms from last week <week04p>`, if they exist?

* Can you find the first and the second component of any pairs in those terms?
  
Check your answers with ``ocaml``/``utop``.

B: Cons exercises
=================

Which of these terms is valid? If it is valid, what is its value, and what is its type?

Check your answers with ``ocaml``/``utop``. 

#. ``3 :: []``
#. ``3 :: 4 :: []``
#. ``3 :: [4]``
#. ``[3] :: []``
#. ``[3] :: 4``
#. ``[] :: []``
#. ``[] :: [[]]``
#. ``[[]] :: []``
#. ``[[]] :: [[]]``
#. ``[] :: [], []``
#. ``[] :: []; []``
#. ``[[] :: []; []]``
   
   (Note: this is very different!)

C: List exercises
=================

Do the exercises from https://ocaml.org/learn/tutorials/99problems.html; solutions are provided.


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

:See also: the assignment_ on Canvas

.. _assignment: https://canvas.bham.ac.uk/courses/15627/assignments/46796


We did some exercises without ``option``. I have here filled in our solutions.


#.  Make a function ``last`` that finds the last element of a list. We want that::
    
        last [3; 5] = 5
        last [3] = 3
        last [] = an error

    (Now you can click on the button below; there is an answer.)

    .. collapse::

        We are making a function on lists, so probably we'll need recursion. (Use ``let rec``.)

        We can make a first attempt by just writing down these cases. Last of a two-element list should return the second element, and so forth. In the "otherwise" case (``_``), we wish to give an error. ::

            let rec last l = match l with
              | [x; y] -> y
              | [x] -> x
              | [] -> failwith "last"
              | _ -> failwith "dunno"

        We can make the last case more specific, because the list will not be empty::

            let rec last l = match l with
              | [x; y] -> y
              | [x] -> x
              | [] -> failwith "last"
              | x::xs -> failwith "dunno"

        We can not list all the possible list length, because a list can be arbitrarily long. So we need to use recursion. Usually, structural recursion is enough. 

        What's the relation between ``last [2; 3; 4]`` and ``last`` of its tail, ``last [3; 4]``?

        They are equal. So we write::

            let rec last l = match l with
              | [x; y] -> y
              | [x] -> x
              | [] -> failwith "last"
              | x::xs -> last (tl l)

        We simplify this in two ways. Firstly, in the last case, we already have ``tl l`` in a variable, namely ``xs``. ::

            let rec last l = match l with
              | [x; y] -> y
              | [x] -> x
              | [] -> failwith "last"
              | x::xs -> last xs

        We also don't need to do the special case for two elements. ::

            let rec last l = match l with
              | [x; y] -> y
              | [x] -> x
              | [] -> failwith "last"
              | x::xs -> last xs

#.  Make a function ``pen`` that finds the penultimate element of a list.
    
    Write down some example inputs and outputs like above, then write the solution.

    .. collapse::

        We want ::

            pen [] = error
            pen [2; 3; 4] = 3
            pen [2] = error
            pen [2; 3] = 2

        Solution::

            let rec pen l = match l with
              | [] -> failwith "pen empty"
              | [a] -> failwith "pen of one element"
              | [a; b] -> a
              | x::xs -> pen xs ;;


#.  Make a function ``pens`` that finds the last two elements of a list and puts them in a pair.

    Write down some example inputs and outputs like above, then write the solution.

    .. collapse::

        We want ::

            pens [3; 4] = (3, 4)
            pens [4] = error
            pens [] = error
            pens [2; 3; 4] = (3, 4)

        Solution::

            let rec pens l = match l with
              | [] -> failwith "pens empty"
              | [a] -> failwith "pens of one element"
              | [a; b] -> (a, b)
              | x::xs -> pens xs ;;

#.  Make a function ``at`` that finds the n'th element of a list. We want::
    
        at 3 [4; 5; 6; 7; 8] = 8
        at 3 [] = error
        at 0 [4; 5; 6] = error
        at (-2) [4; 5; 6] = error
        at 1 [4; 5; 6] = 4

    Note that usually when programming, we count from 0 because it tends to make things easier. For some mysterious reason, the exercise designers have chosen to count from 1 here.

    .. collapse::

        ::

            let rec at k l = match l with
            | [] -> failwith "at"
            | x::xs -> if k < 1 then failwith "at" else if k = 1 then x else at (k-1) xs;;

        (Note that I forgot to write the ``if k = 1 then x else`` in the tutorial, which some students helpfully pointed out.)
