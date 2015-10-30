********************************************************
Week 5 reasoning (Part 2): Explanation for Currying, bool*bool, and Sum Types
********************************************************

.. highlight:: ocaml
.. default-role:: code


:Subsite home page: http://bit.ly/focs-aux


Isomorphisms:
==================

Suppose ``f`` is a way to assign a term ``b`` in ``'b`` for each term ``a`` in ``'a``, and ``g`` is a function that assigns to every term ``b`` in ``'b`` a term ``a`` in ``'a``. :: 


    f: `a -> `b 
    g: `b -> `a 


Think of ``f`` and ``g`` as processes. If we have the following conditions then we say ``f`` and ``g`` are inverses of each other and as a result type ``'a`` and ``'b`` are ismorphic. ::



    f.g = id_`b
    g.f = id_`a


The first condition indicates that ``g`` is a section and ``f`` is a retraction. 
If both f and g are sections and retractions then they must be inverses of each other. 


Note that composition of functions is defiend as follows::

    g.f == fun x -> g (f x)


And identity function is defiend as ::

    let id x = x 






Curry and uncurry:
==================

This is how we write the code for curry and uncurry functions::

    let curry (f: (('a * 'b) - > 'c)) = 
        fun (a: 'a) -> 
            fun (b: 'b) ->
                f(a,b) ;; 


    let uncurry (f: ('a -> 'b -> 'c) = 
        fun ((a,b) : ('a * 'b))-> f a b ;;


 check that ::

    curry(uncurry f) = id at 'a -> 'b -> 'c
    uncurry(curry f) = id at ( 'a * 'b) -> 'c

	

A good analogy between currying and uncurrying and a law of numerical exponentials:
Remember this is only an anology and it's not a valid O'Caml code:: 

    uncurry (2 ** 3) ** 5 = 2 ** (3 * 5)
    curry   2 ** (3 * 5) = (2 ** 3) ** 5



The upshot of this is that currying and uncurrying establish an isomorphism between following types::

 
    ('a * 'b) - > 'c and 'a -> 'b -> 'c






Sum type: 
=========


As in mathematics for any two sets we have union of those two sets, in types we have a corresponding notion. It's called sum types::

    type ('a, 'b) sum = 
        |left of ('a)
        |right of ('b) ;;




            

There are two functions from product type to sum type::



    ProductToSum1 (a,b) = Left a ;; 
    ProductToSum2 (a,b) = Right b ;; 

Convince yourself that there can not be an isomorphism between sum type and product type. 




Another Isomorphism
===============================================================

There is an isomorphism between the types ``(bool -> bool)`` and ``bool*bool``. 

In order to establish this ismorphism we need to implement a pair of functions which are inverse of each others; we call them enc and dec for encoding and decoding respectively. 					


let's see how we can define the decoding fnction. First, we should specify the type of decoding function:: 



    dec: (bool -> bool) -> bool*bool
    
And the function itself is defined as ::
	
    let dec: (bool -> bool) -> bool*bool = 
    fun (f: bool -> bool) -> (f(false),f(true)) ;;


	
	
	
.. pull-quote::
	
    How about the inverse?
	
	
Just by virtue of being the inverse of ``dec``, the function ``enc`` can be uniquely defined. 
It means that starting from a pair ``(a,b)`` of type ``bool*bool``, we  should have ``dec(enc(a,b)) = (a,b)``. 
So, what could ``enc(a,b)`` be? 
As it should be obviosu to you by now, it is the function ``f`` such that ``f(flase) = a`` and ``f(true) = b`` 
