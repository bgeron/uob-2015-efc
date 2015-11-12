
********************************************************************
Week 7: Explanation for exercise 6.1 (Symmetric Difference of Lists)
********************************************************************

.. highlight:: ocaml
.. default-role:: code

:Subsite home page: http://bit.ly/focs-aux


Exercise 6.1
============

Implement the function ``diff`` which computes the symmetric difference of two lists, which means collecting all of the elements that appear only in one of the lists. The order of the remaining elements should stay unchanged. 
Remember we are interested in collecting elements that appear exactly in one of the lists. In particular, elements that appear in both lists ``l1`` and ``l2`` should not be in ``diff l1 l2`` . 


Example:

``l1 = [1;2;3;2;3]``

``l2 = [3;4;3]``

``diff l1 l2 = [1;2;2;4]`` 






We do this exercise in three steps: 


First step:
===========

First we define a function called subdif that takes a list and an entry and returns a list with all elements different than the given entry ::

    subdif: 'a list -> 'a -> 'a list

Let's see how subdif works ::

    subdif [1;2;3;2;3] 3 =
    1 :: subdif [2;3;2;3] 3 = 
    1 :: 2 :: subdif [3;2;3] 3 = 
    1 :: 2 :: subdif [2;3] 3 = 
    1 :: 2 :: 2 :: subdif [3] 3 =
    1 :: 2 :: 2 :: [] = 
    [1;2;2] 



And this is how we define the function ``subdif`` :: 

    Let rec subdif l ent = match l with 
                          | [] -> [] 
                          | x :: xs -> 
                            if (x = ent) then subdif xs ent 
                            else x :: subdif xs ent 



				
				
				
Second step:
============					  

In the second step, we define another function which we call ``prediff``. 
We expect this function to take two lists ``l1`` and ``l2`` and return all of elements in ``l1`` which are not in ``l2``. 
Note that this function is not symmetric with respect to the two lists ``l1`` and ``l2``. So, this cannot be our final answer. 

The type of this function would then be ::

    predif: 'a list -> ' a list -> 'a list



And the function itself is ::


    Let rec predif l1 l2 = match l2 with 
                       | [] -> l1
                       | x ::xs -> predif (subdif l1 x) xs ;; 




Now let's look at some computation done with the function we just defined ::


    predif [1;2;3;2;3] [3;4;3] = 
    predif (subdif [1;2;3;2;3] 3) [4;3] =
    predif [1;2;2] [4;3] =
    predif (subdif [1;2;2] 4) [3] =
    predif ([1;2;2]) [3] =
    predif (subdif [1;2;2] 3) [] =
    predif [1;2;2] [] =
    [1;2;2]



	
	
Final step:
===========



Now finally we can define symmetric difference function ``diff``.


It has the type ::

    diff: 'a list -> 'a list -> 'a list 

And the function itself ::	
	
	
    Let rec subdif l ent = match l with 
                        | [] -> [] 
                        | x :: xs -> 
                          if (x = ent) then subdif xs ent 
                          else x :: subdif xs ent 


    Let rec predif l1 l2 = match l2 with 
                        | [] -> l1
                        | x ::xs -> predif (subdif l1 x) xs 



    Let rec diff l1 l2 = append (predif l1 l2) (predif l2 l1) ;;




	
	

A set theoretical remark:
=========================



It's hard to not notice that our definition of symmetric difference of lists is analogous to of symmetric difference of sets, except that the case of sets is even simpler because we don't care about maintaining the order while we are taking the difference.


In other words, since sets do not have order structure, there is nothing to be checked about order preservation. 

For symmetric difference of sets look at:  https://en.wikipedia.org/wiki/Symmetric_difference





A different and shorter solution:
=================================


Remark: There is a library function val filter which you might find useful in order to come up with another solution for this exercise::

    val filter : ('a -> bool) -> 'a list -> 'a list


``filter p l`` returns all the elements of the list ``l`` that satisfy the predicate ``p``. The order of the elements in the input list is preserved.

The following function computes symmetric difference ::

    let predif xs ys = filter (fun x -> not (mem x ys)) xs 


where ::

    val mem : 'a -> 'a list -> bool
    mem a l is true if and only if a is equal to an element of l. 