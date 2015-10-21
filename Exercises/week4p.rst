
********************************************
Week 4 tutorial programming exercises: Lists
********************************************

What does this function compute? ::

    let f = function
    | [_;1;_] -> true
    | _ -> false

.. collapse:: 

    This one is from the lecture questionnaire_.

    True only for lists of 3 elements with second element 1.
    
What does this function compute? ::

    let g = function x :: y :: _ -> x + y

.. collapse::

    This one is from the lecture questionnaire_.

    the sum of the first two elements of a list of at least two elements

What does this function compute when applied to ``[(1,2);(3,4)]``? ::

    let h = function 
    | x -> snd x
    | x :: y -> snd y

.. collapse::

    This one is from the lecture questionnaire_.

    ::

        utop # let h = function 
        | x -> snd x
        | x :: y -> snd y;;

        Error: This expression has type 'a list
        but an expression was expected of type 'b * 'c

    (Try it.)

    There is an error in **both** ``snd x`` and ``snd y``.

What does this function compute when applied to ``[(1,2);(3,4)]``? ::

    let h = function 
    | x -> failwith "error"
    | x :: y -> failwith "error"

.. collapse::

    A run-time error. **Not** a compile-time error.

Which of these three functions compile, and when does it give a result when applied to [(1, 2); (3, 4)]? ::

    let f = function 
        | x -> snd x
        | x :: y -> failwith "error";;

    let g = function 
        | x -> failwith "error"
        | x :: y -> snd x;;

    let h = function 
        | x -> failwith "error"
        | x :: y -> snd y;;

.. collapse::

    ``f`` does not compile. The reason is that it knows that the argument must be a list. (It knows because apparently the argument can possibly match ``x :: y``.) Therefore, ``snd x`` makes no sense at all to OCaml.

    ``g`` compiles, and if you call it with a non-empty list of pairs, it works. It returns 2 in this case. 

    ``h`` does not compile, for a reason similar to ``f``. OCaml deduces that the argument type must be a list. In the case of ``x :: y``, that means that ``x`` is an element of that list, and ``y`` is the rest of the list (*which is a list*).


(To do: more exercises hopefully.)

.. comment

    [ group ]

    [ which fits? ]





   
.. _questionnaire: https://docs.google.com/forms/d/1OtE6iWGgdQpnWwIZzZSdlBBafm7vNjqWgevVnTgqYV0/viewform

