
*************************************
Week 2 tutorial programming exercises
*************************************

.. highlight:: ocaml

.. default-role:: code

.. |ex| replace:: **Exercise.**

:Author: Bram Geron

:Description: These exercises are to assist in the programming remedial tutorials.

:Subsite home page: http://bit.ly/focs-aux

----


You will receive this sheet with the questions; all the answers are on the indicated URL (but collapsed).

You can also find the answer by opening ``utop`` or ``ocaml``, and I highly recommend to install ``utop``.

Try it: enter `3 + 4 ;;` and verify that the result is ``7``.


Syntax and precedence
=====================

The basic elements of OCaml are:

Variables
    These are "names". Examples::

        x, f, g, three, double, twice

    OCaml can remember a meaning for variables if you use ``let`` (see below).

Constants
    Examples of integer constants::

        42, -3

Arithmetic
    Nothing surprising. ::

        3 + 4
        4 * 5

    Like in school, you can write complex expressions, such as ::

        3 + 4 * 5

    Like in school, this means::

        3 + (4 * 5)

Defining variables
    ::

        let x = 3;;

    ::

        let three = 1 + 2;;

    From now on, OCaml knows that ``three + three`` = ``3 + 3`` = ``6``.

    When you define a variable like this, it stays until you redefine it.


Let..in..
    You can also "temporarily" define a variable.

    For instance, let's say that ``x`` is not yet defined. Then ::

        let x = 3 in 3

    evaluates to 3, and ::

        let x = 3 in x + 3

    evaluates to 6.

    |ex| Add the right brackets here.

    .. collapse::

        ::

            let x = 3 in (x + 3)

    You can temporarily define multiple variables; this is nothing special. Example::

        let x = 3 in let y = 4 in x + y

    Now let's add parentheses::

        let x = 3 in (let y = 4 in (x + y))

Evaluation
==========

To evaluate ``let variable = expression1 in expression2``:

#. Try to simplify (evaluate) ``expression1`` as far as you can.
#. Draw a big box around ``expression2``
#. In the right-hand corner of it, write ``variable = simplifiedexpression1``.
#. Erase ``let variable = ...``.
#. Continue working in 
   
To evaluate a variable ``x``:

#. Find the innermost box that is annotated with ``x = value``
#. Replace ``x`` where you wanted to evaluate it with ``value``.

When you have a number (in general, a value) in the innermost box, then you can erase all the boxes.

|ex| Evaluate all the expressions from the last section.

Exercises
---------

Calculate by hand the value of the expressions below, or say that it returns an error. Use the method above.

OCaml keywords are printed in bold. Bold does not mean anything, but might make the code easier to read.

1.  Evaluate all expressions in the previous section.

#.  . ::
    
        let x = 3 in (let y = 4 in (x + y))

    .. collapse:: 7.

#.  We can use multiple let..in.. in a different way. ::

        let x = let y = 3 in 2 * y in 2 * x

    First, add the right parentheses.

    Then, compute the result.

    .. collapse::

        Before we draw any boxes, we simplify `let y = 3 in 2 * y`. Draw a box with ``y = 3``, fill in ``y``, simplify to 6.

        Then you can draw a box with ``x = 6``. Fill in ``x``, simplify to 12.


Other
=====

Exercises
---------


As before.




#.  . ::

       let f x = 3 * x in let g x = 3 + x in f (g 4)

    .. collapse::

        21

        This was from the lecture: http://bit.ly/focs04a

#.  . ::

        let f g = g (g 1) in let h x = x + x in f h

    .. collapse::

        The answer is the same as the next exercise. I just renamed the variables and swapped the ``let``\ s.

        Let's do it in steps. First, I'll lay out the code differently. ::

            let f g = g (g 1) in
            let h x = x + x
            in f h

        Then I'll reorder the lets.

            let h x = x + x
            let f g = g (g 1) in
            in f h

        Then I'll rename the variables.

            let f x = x + x
            let g h = h (h 1) in
            in g f

        Now it should be obvious.

        .

        You cannot always reorder the lets. Can you give an example?

#.  . ::

        let f x = x + x in let g h = h (h 1) in g f

    .. collapse::

        The exercise is easier when we rename the variables::

            let double x = x + x in
            let apply_twice_to_one h = h (h 1) in
            apply_twice_to_one double


        This was from the lecture: http://bit.ly/focs04b

Quiz
====

Please take the quiz: http://bit.ly/focs-aux-survey

.. image:: ../resources/focs-aux-survey.png
    :scale: 30%

