
**********************************************************
Week 2 tutorial programming exercises: Thinking like OCaml
**********************************************************

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

    You should always add the right bracket as far to the right as possible.

    |ex| Add the right brackets here.

    .. collapse::

        ::

            let x = 3 in (x + 3)

    You can temporarily define multiple variables; this is nothing special. Example::

        let x = 3 in let y = 4 in x + y

    Now let's add parentheses:

    .. collapse::

        ::

            let x = 3 in (let y = 4 in (x + y))

    You can combine multiple let..in.. in a different way. Parenthesise::

        let x = let y = 4 in y in x

    |ex| Add parentheses. There is only one way that you can add parentheses, all other ways are invalid OCaml.

    |ex| Can you see why all other parenthesisations are invalid?

    .. collapse::

        ::

            let x = (let y = 4 in y) in x





Let-bindings, variables, evaluation
===================================

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

----

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

#.  Parenthesise, then solve. ::
        
        let x = let y = 5 in 3 in let y = 4 in x * y

    .. collapse::

        - Simplify the ``x =`` part. Inside it, replace ``let y = 5 in`` with a bubble. Simplifying 3 is finished, so erase the bubble again.
        - We now have ``let x = 3 in``. Draw a bubble for it.
        - We now have ``let y = 4 in``. Draw a bubble for it.
        - Replace x by 3 and y by 4.
        - Simplify ``3 * 4`` to 12.

        If you try it in utop, you will get a warning that you have an unused variable. This is okay.

        Often, unused variables mean you are doing unnecessary computations. Indeed, we did ``let y = 5 in`` but it was useless.

#.  Parenthesise, then solve. ::
        
        let x = let y = 5 in 3 in y

    .. collapse::

        - Simplify the ``x =`` part as in the previous exercise. You now have ``let x = 3 in y``.
        - Make a bubble with ``x = 3`` in the corner.
        - ``y`` is undefined, so ERROR.

#.  Parenthesise, then solve. ::
    
        let x = 2 in let x = x + 1 in x

    .. collapse::

        Answer: 3.

#.  Parenthesise, then solve. ::
        
        let x = 2 in let y = x + 1 in y * let y = y + 1 in y

    .. collapse::

        ::

            let x = 2 in (let y = (x + 1) in y * (let y = y + 1 in y))

        - Draw a bubble with x = 2.
        - Replace ``x`` in ``x + 1`` with ``2``, simplify 2+1 to 3.
        - Draw a bubble with y = 3
        - Replace ``y`` in ``y + 1`` with ``3``, simplify 3+1 to 4.
        - Replace inner ``y`` with 4.
        - Erase bubble
        - Replace ``y`` with 3.
        - Simplify 3 * 4 = 12


|ex| If time: make an expression for your neighbour with between 2 and 4 uses of ``let..in..``. Solve it yourself, let them solve it, and compare your answers.

Anonymous functions
===================

Anonymous functions (or *lambdas*) are integral to programming.

They look like this::

    fun x -> x + 3

Also very important is *function application*. For instance, ::

    (fun x -> x + 3) 4

The parentheses always go as far to the right as possible::

    fun x -> (x + 3)

for the first example, and for the second example ::

    (fun x -> (x + 3)) 4

Be careful! Space is not just space separating two things, but it has meaning. Space is called *application*, and you have to simplify when you can.

Application works the same as let..in.. . Draw a bubble with ``x = 4``, and evaluate ``x + 3``. The value of ``(fun x -> (x + 3)) 4`` is 7.

Exercises
---------

8.  Parenthesise and evaluate. ::
        
        (fun x -> 2 * x) 3

    .. collapse:: Answer: 6.

#.  Parenthesise and evaluate. ::
        
        (fun x -> 2 * x) 3 + (fun x -> x + 1) 3

    Note that you will have multiple bubbles here.

    .. collapse:: Answer: 10.

#.  Evaluate. ::
        
        2 + (fun whatever -> whatever * whatever) 10

    .. collapse:: Answer: 102.

Higher-order functions
======================

Putting functions in the environment ("in the bubble") is nothing special. 


Exercises
---------

11. Parenthesise and evaluate. Add parentheses when you need to. ::
     
        let f = (fun x -> x * 2) in f 3

     .. collapse::

        * Make a bubble, write ``f = fun x -> x * 2`` in the corner of it.
        * Replace ``f`` by ``(fun x -> x * 2)`` (add parentheses!)
          
          Now you have ``(fun x -> x * 2) 3``

        * Make a bubble with ``x = 3``
        * Simplify ``x * 2`` to 6.
          
#.  Parenthesise and evaluate. ::
    
        let f = (fun x -> x * 2) in f (f 3)

    .. collapse::

        Same, but you have to replace ``f`` twice, and you get an application twice. The result is 12.

Named functions
===============

Instead of ::

   let f = (fun x -> x * 2) in f 3

we can write ::

   let f x = x * 2 in f 3

which means exactly the same. When you draw the bubble, write ::

    f = fun x -> x * 2

in the bubble.

Exercises
---------


13. Parenthesise and evaluate. Add parentheses when you need to. ::
     
        let f x = x * 2 in f 3

    .. collapse::

        As before.

        * Make a bubble, write ``f = fun x -> x * 2`` in the corner of it.
        * Replace ``f`` by ``(fun x -> x * 2)`` (add parentheses!)
          
          Now you have ``(fun x -> x * 2) 3``

        * Make a bubble with ``x = 3``
        * Simplify ``x * 2`` to 6.
          
#.  Parenthesise and evaluate. ::
     ::
        let f x = x * 2 in f (f 3)

    .. collapse::

        Same, but you have to replace ``f`` twice, and you get an application twice. The result is 12.

#.  Parenthesise and evaluate. ::
        
        let f x = x * 2 in f x

    .. collapse::

        * Draw the bubble with ``f = fun x -> x * 2``.
        * ``x`` is not in a bubble, so we cannot simplify it. Error!

#.  Evaluate. ::

       let f x = 3 * x in let g x = 3 + x in f (g 4)

    .. collapse::

        21

        This was from the lecture: http://bit.ly/focs04a

#.  Evaluate. ::

        let f x = x + x in let g h = h (h 1) in g f

    .. collapse::

        The exercise is easier when we rename the variables::

            let double x = x + x in
            let apply_twice_to_one h = h (h 1) in
            apply_twice_to_one double

        The answer is 4:

        * Write a bubble ``f = fun x -> x + x``
        * Write a bubble ``g = fun h -> h (h 1)``
        * Substitute ``g`` to get ::
            
            (fun h -> h (h 1)) f

          inside the two bubbles

        * Substitute ``f`` to get ::
            
            (fun h -> h (h 1)) (fun x -> x + x)


          inside the two bubbles

        * Write another bubble ``h = fun x -> x + x``; inside it ``h (h 1)``
        * Fill in ``h`` in the inside
        * In the brackets, make a bubble with ``let x = 1``; the bubble contains ``x + x``. Simplifies to ``2``. Remove the ``x`` bubble.
        * You have ``h 2`` left. Make a bubble with ``x = 2`` and ``x + x`` inside it. This simplifies to 4.
        * Remove the ``h`` bubble, the ``g`` bubble, and the ``f`` bubble.

        The answer is 4.


        This was from the lecture: http://bit.ly/focs04b

#.  Evaluate. ::

        let f g = g (g 1) in let h x = x + x in f h

    .. collapse::

        The answer is the same as the previous exercise. I just renamed the variables and swapped the ``let``\ s.

        Let's do it in steps. First, I'll lay out the code differently. ::

            let f g = g (g 1) in
            let h x = x + x
            in f h

        Then I'll reorder the lets. ::

            let h x = x + x
            let f g = g (g 1) in
            in f h

        Then I'll rename the variables. ::

            let f x = x + x
            let g h = h (h 1) in
            in g f

        Now the correspondence should be obvious.

        .

        You cannot always reorder the lets. Can you give an example?

Quiz
====

Please take the quiz: http://bit.ly/focs-aux-survey

.. image:: ../resources/focs-aux-survey.png
    :scale: 30%

