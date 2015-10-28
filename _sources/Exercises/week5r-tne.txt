
*****************************************
Week 5 reasoning: explanation for ``tne``
*****************************************

.. highlight:: ocaml
.. default-role:: code


:Subsite home page: http://bit.ly/focs-aux

This page explains how to solve exercise 4.3. The question was as follows:

.. pull-quote::

    Implement an OCaml function called ``tne`` of type ``((('a -> 'b) -> 'b) -> 'c) -> 'a -> 'c``.

    Important: You may only use function definition (``let``) and function application. 

The solution is given `on GitHub <https://github.com/Duta/focs-2015-16/blob/master/solutions/week-4/exercise-3/wk4ex3.ml>`_, but on this page we show how in detail you can get that answer.

A simpler exercise
==================

Exercise 4.0 was this:

.. pull-quote::

    Write a function ``dni`` of type ``'a -> (('a -> 'b) -> 'b)``.

Let us do this first.

Note that ::

    'a -> (('a -> 'b) -> 'b)

is the same type as ::

    'a -> ('a -> 'b) -> 'b

namely the type of functions that accept a value of type ``'a``, a value of type ``'a -> 'b``, and return a value of type ``'b``. We start making a function the usual way::

    let dni x f = ??? ;;

Here ``x`` will be the first argument, and ``f`` will be the second argument, so the types of ``x`` and ``f`` are ::

    x : 'a
    f : 'a -> b

Remember that this means that ``f`` is a function that turns something of type ``'a`` into something of type ``'b``. To say the same with different words: it accepts a value of type ``'a`` and returns something of type ``'b``. 

Now in the question marks, we need to make something of type ``'b``. How do we do this? Well, we can feed ``x`` into ``f``, because ``x`` is of type ``'a``; we just saw that the result will be of type ``'b``. The way you apply a function to an argument in OCaml is::

    f x

So if we fill this in in the question marks, we get a definition for ``dni``::

    let dni x f = f x ;;

Now let's analyse the type of the value ``dni`` that we just created. It takes an ``'a`` argument and an ``'a -> 'b`` argument, and it returns a ``'b``. That means that its type is ::

    'a -> ('a -> 'b) -> 'b

Please now enter the definition of ``dni`` in OCaml or utop, to convince yourself. Entering values in OCaml/utop is a great way to see if you understand OCaml correctly.

Another simple exercise
=======================

On the whiteboard today, I did a similar exercise, which will help us greatly.

.. pull-quote::

    Assume that there is some ``z`` of type ``'a``. Make a function ``g`` of type ``('a -> 'b) -> 'b``.

You see from the type that it takes one argument, so let's start the usual way::

    let g f = ??? ;;

Argument ``g`` will be of type ``'a -> 'b``. That is, it turns ``'a``\ s into ``'b``\ s. So we feed it ``z``::

    f z

This is of type ``'b``, which is what we needed to make. The solution is::

    let g f = f z ;;

The real exercise
=================

.. pull-quote::

    Implement an OCaml function called ``tne`` of type ``((('a -> 'b) -> 'b) -> 'c) -> 'a -> 'c``.

Let's start the usual way. We won't need recursion. ::

    let tne h z = ??? ;;

where ::

    h : (('a -> 'b) -> 'b) -> 'c
    z : 'a

and we have to make something of type ::

    'c

(Note that we have 'received' our ``z`` from the previous part!)

This is not very nice. We have to make something, but we don't even know what its type is: we might have to make a string, a bool, or an int! 

Luckily, we have a machine for producing a ``'c``; it's called ``h``. But first we have to give ``h`` its argument, which must be of type ``('a -> 'b) -> 'b``. Jolly, how could we ever obtain such a thing?

.. skip:: big

Of course, we just made it in the previous part: it's called ``g``. So the solution is::

    let tne h z = h g ;;

.. skip:: big

Actually, there's a bit of a problem. OCaml will not accept this, because it cannot comprehend that ``z`` in the definition of ``g`` is the same ``z`` as in the definition of ``tne``. If you first define ``g`` as above, it will tell you that it doesn't know ``z``; if you first try to define ``tne``, it will tell you it doesn't know ``g``.

We now realise that we are constantly using the :ref:`named function <named-function-explanation>` abbreviation from week 2. (Click the link if you want a quick refresher.) In the previous exercise, we wrote ::

    let g f = f z ;;

but we could have written just as well ::

    let g = fun f -> f z ;;

And we can use this to fix our definition for ``tne``! We don't use ``g`` but its expansion. ::

    let tne h z = h (fun f -> f z) ;;

This works: OCaml sees that the ``z`` on the right comes from the ``z`` argument on the left.

.. skip:: big

Now let's look at what the type is of this.

* We saw previously that if ``f`` is of type ``'a -> 'b``, then ``f z`` is of type ``'b``.
* ``(fun f -> f z)`` takes a ``'a -> 'b`` and produces a ``'b``, therefore ``(fun f -> f z)`` is of type ``('a -> 'b) -> 'b``.
* We assumed that ``h`` is of type ``(('a -> 'b) -> 'b) -> 'c``. Then we give ``h`` just the right type of input! We see that ``h (fun f -> f z)`` is of type ``'c``.
* ``tne`` takes two arguments, namely something of type ``(('a -> 'b) -> 'b) -> 'c`` and something of type ``'a``, and we saw that it produces a ``'c``. Therefore, the type of ``tne`` is ::
  
        ((('a -> 'b) -> 'b) -> 'c) -> 'a -> 'c

Indeed, OCaml calculates exactly this when you enter the definition of ``tne`` in it..

Epilogue
========

This stuff might look nasty to young eyes. 

Why did we do this? We want you to be rockstar programmers.

Many programmers just tie together frameworks and libraries to build applications, and they need to understand only simple ("first-order") functions for this. (Libraries are often written using "higher-order" functions, which is the opposite of first-order.) Those programmers build things that impress many people and have great societal impact. But every so often, they want to go beyond the range of apps that people have envisioned before, and the libraries they need will not exist. In fact, very often libraries exist that do what you want, except for something small that's missing, or maybe there's a small bug in the library. You can only understand those libraries, let alone improve on them, if you understand the techniques needed to build the library.

In fact, `this very site you are on <https://github.com/bgeron/uob-2015-efc/raw/master/Exercises/week5r-tne.rst>`_ was written using Sphinx_\ , which was created for something completely else: to make a `documentation site <https://docs.python.org/3/>`_ for the programming language Python. I was lucky enough that Sphinx already supported nice code highlighting, that is: I type OCaml and Sphinx automatically adds the fancy colours you see everywhere that make the code easy to read. However, the documentors of Python never needed :ref:`silly boxes that you can click to show a solution <examples-of-collapse>` (src_); why would they? So I added_ those_ to Sphinx myself_. 

.. _Sphinx: http://sphinx-doc.org/
.. _src: https://github.com/bgeron/uob-2015-efc/raw/master/Exercises/week4p.rst
.. _added: https://github.com/bgeron/uob-2015-efc/blob/master/helpers/collapse.py
.. _those: https://github.com/bgeron/uob-2015-efc/blob/master/_static/collapse-details-polyfill.css
.. _myself: https://github.com/bgeron/uob-2015-efc/blob/master/_static/collapse-details-polyfill.js

It's great feeling able to make anything. I don't settle for less. Neither should you, and you don't have to.

Keep pushing yourself.

And keep asking questions.
