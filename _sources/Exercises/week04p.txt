
******************************************************
Week 4 programming: Tuples and lists: values and types
******************************************************

.. highlight:: ocaml
.. default-role:: code

:Subsite home page: http://bit.ly/focs-aux

This week, we practiced values and types of tuples. Next week, I plan to do exercises on calculating with lists.

On this page, I first explain again what tuples and lists are. Then I give a list of exercises, in roughly ascending difficulty. It is roughly what we did in the tutorial.

Please do make liberal use of utop to verify what you think, and just to play around.

Finally, I give a few examples of when you might use certain types.

----

If you print this page, you get a nice blank space where you can write down your answer. If you view this page online, you can click on the grey boxes to see the answers.

Tuples and lists
================

Tuples and lists are two ways to group data together. Tuples group a fixed number of things that can be of any type; lists group *any* number of things of the same type.

Tuples are indicated with a comma ``,``, for instance ``3,4``. People often write parentheses around them: ``(3, 4)``. The type of this is ``int * int``: "an ``int`` together with another ``int``".

We sometimes say that ``()`` is the empty tuple. Its type is ``unit``, and it is the only value of that type.

Lists are indicated with ``[`` and ``]``; they can contain 0 values (like ``[]``), 1 value (like ``[3]``), or many values separated by semicolons, like ``[3; 4; 5]``. It is an error to use semicolons outside of ``[]``. 

When the values inside the list are of some type ``A``, the list is of type ``A list``. So, ::

    val 3 : int
    val [3; 4] : int list
    val [[3; 4]; [5; 6]] : int list list

The empty list can be seen as a list of *any* type. Ocaml writes this as ``'a list``. Here, ``'a`` stands for "any type".

----

In this exercise set, we will use numbers of type ``int``, strings of type ``string``, tuples, and lists.

.. _examples-of-collapse:

Exercise.
=========

Are these correct values? When they are, what is their type?

#.  ``3``

    .. collapse::

        This is an ``int``. 

#.  ``"3"``
    
    .. collapse::

        This is a ``string``. (OCaml will say ``bytes``.)

#.  ``[3]``

    .. collapse::

        The type is ``int list``; it contains one value (``3``) of type ``int``.

#.  ``["a"]``

    .. collapse::

        The type is ``int list``; it contains one value (``"a"``) of type ``string``.

#.  ``(3, 4)``

    .. collapse::

        The type is ``int * int``; it contains two values which happen to be of the same type.

#.  ``(3, "a")``
    
    .. collapse::

        The type is ``int * string``; it contains two values.

#.  ``[3; 4]``

    .. collapse::

        The type is ``int list``. It contains two values, ``3`` and ``4``. Note that ``int`` appears only once in the type because the things in a list must be of the same type; you cannot have a list of ``int``\ s and ``string``\ s.

#.  ``[3; 4; 5]``

    .. collapse::

        The type is ``int list``.

#.  ``[]``

    .. collapse::

        The type can be ``int list`` or ``string list``. The elements might also be ``int list``\ s themselves, in which case this is an ``int list list``. In general, we'll say it's an ``'a list``, which means that it can become a list of any list-type.

#.  ``[[3; 4]]``

    .. collapse::

        3 and 4 are ``int``\ s, so ``[3; 4]`` is an ``int list`` and contains 2 values. ``[[3; 4]]`` is a list that contains only one thing, namely the list ``[3; 4]``. The type is ``int list list``. 

#.  ``3, 4``

    .. collapse::

        This is a tuple of an int and an int, so ``int * int``.

#.  ``3; 4``

    .. collapse::

        This is invalid syntax for a value.

        However, OCaml does give a result. This is because ``;`` also has a different meaning, which you might learn about later; it is not important now.

        You should see this as an invalid value for now.

        OCaml says this::

            utop # 3; 4;;
            Characters 0-1:
            Warning 10: this expression should have type unit.
            Characters 0-1:
            Warning 10: this expression should have type unit.
            - : int = 4



#.  ``(3)``

    .. collapse::

        This is the same as ``3``, just an ``int``. 

#.  ``(3, 4)``

    .. collapse::

        Same as ``3, 4``, this is of type ``int * int``. 

#.  ``(3; 4)``

    .. collapse::

        Invalid syntax. (However, see question 12.)

#.  ``[3, 4; 5]``

    .. collapse::

        This would be a list of two things. We have ``3, 4`` of type ``int * int`` and ``5`` of type ``int``. The types of the elements of the list are not the same, so this is not a valid list.

        OCaml will say this::

            utop # [3, 4; 5];;
            Error: This expression has type int but
            an expression was expected of type
                     int * int


#.  ``[3, 4; 5, 6]``

    .. collapse::

        This is a list of two things, namely ``3, 4`` and ``5, 6``, both of which are a pair of ints, so an ``int * int``. The list is of type ``(int * int) list``. 

#.  ``[[]]``

    .. collapse::

        We saw that ``[]`` is of type ``'a list``. Now ``[[]]`` is a list with that one thing in it, so it is of type ``'a list list``. 

#.  ``[], [3]``
    
    .. collapse::

        This is a tuple of two things, namely ``[]`` (of type ``'a list``) and ``[3]`` (of type ``int list``). Therefore, this is of type ``('a list) * (int list)``.

#.  ``[["3"]; [3]]``

    .. collapse::

        This would be a list of two things. Remember that in lists, the type of all elements must be the same. Now ``["3"]`` is a ``string list``, and ``[3]`` is an ``int list``, so this is a type error. 

        The error that OCaml gives is::

            utop # [["3"]; [3]];;
            Error: This expression has type int but an expression
            was expected of type bytes

#.  ``([3, 4], 5)``

    .. collapse::

        First, look at ``3, 4``. Comma means it's a tuple, namely a ``int * int``.

        Then square brackets makes a list, and there are no semicolons to separate the elements, so it's like ``[42]``: just one element. Value ``[3, 4]`` is of type ``(int * int) list``.

        Then, look at ``[3, 4], 5``. The comma means it's a pair: the first element is of type ``(int * int) list`` and the second of type ``int``. So this is an ``(int * int) list * int``. 

        Parentheses don't change the type. (Remember that ``(3)`` = ``3`` is of type ``int``.)

#.  ``([3, 4]; 5)``

    .. collapse::

        There is a semicolon without square brackets, so this is invalid syntax.

        However, OCaml does give a result::

            utop # ([3, 4]; 5);;
            Characters 1-7:
            Warning 10: this expression should have type unit.
            Characters 1-7:
            Warning 10: this expression should have type unit.
            - : int = 5

        This is because ``;`` also has a different meaning, which you might learn about later; it is not important now.

        You should see this as an invalid value for now.

#.  ``([3; 4]; 5)``

    .. collapse::

        Same as last question: there are no square brackets so the semicolon does not make a value.

#.  ``([3; 4], 5)``

    .. collapse::

        Comma, so this is a tuple of two elements: ``[3; 4]`` of type ``int list`` and 5 of type ``int``. The type is ``int list * int``. 

#.  ``[[]; [3]]``

    .. collapse::

        Here, we have a list of two things, ``[]`` (of type ``'a list``) and ``[3]`` (of type ``int list``). You might think that you cannot combine those things together. However, ``'a list`` means that it can become a list of any type, and OCaml sees that here we want to make ``[]`` an ``int list``, which is possible. The type of ``[[]; [3]]`` is ``int list list``. 

#.  ``[[], [3]]``

    .. collapse::

        This is a slightly mean question. Comma means make a tuple of two elements: ``[]`` of type ``'a list`` and ``[3]`` of type ``int list``. Tuples can hold values of different types, so we don't need to change the ``'a`` into anything: ``[], [3]`` is of type ``'a list * int list``.

        Similarly to ``[3]``, we have a list of one thing because there are no semicolons in the ``[ ]``. So this is of type ``('a list * int list) list``.


Applications
============

Let's look at some types that are useful. Let's say that we want to make a phone book, that is, store names and numbers. Say that the number of Bram is 123, and the number of Sina is 234.

We can lay this out in two ways: we can make the pairs ``("Bram", 123)`` and ``("Sina", 234)``, and put them in a list::

    [("Bram", 123); ("Sina", 234)] : (string * int) list

We can also make a list of names ``["Bram"; "Sina"]`` and ``[123; 234]`` and put them together::

    (["Bram"; "Sina"], [123; 234]) : string list * int list

In practice, the former layout is often handier.

----

An application like `Google Contacts <https://contacts.google.com/>`_ (to which your smartphone phonebook might be synchronised if you use Android) contains many phone books, so they might store a value of type ``(string * int) list list``.

On the other hand, for every phonebook they also have the name of the phonebook owner. So they might bundle together Dan's name with his phonebook::

    ("Dan", [("Bram", 123); ("Sina", 234)]) : string * (string * int) list

There are many choices you can make about how to structure your data (tuples, lists, tuples of lists, lists of tuples, ...) and what is handiest depends on the situation.

Later in this module or your studies you might learn ways to give names to such structures, so that it's easier to see what you're doing :)


   
.. _questionnaire: https://docs.google.com/forms/d/1OtE6iWGgdQpnWwIZzZSdlBBafm7vNjqWgevVnTgqYV0/viewform

