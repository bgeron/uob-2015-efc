
******************************************
(Week 10 programming: exercises of week 9)
******************************************

.. highlight:: ocaml

Question 1
==========

Implement subtraction for Peano numbers. The function needs to be tail-recursive. ::

    type nat = Zero | Suc of nat;;
    val sub : nat -> nat -> nat = <fun>
    # sub (Suc Zero) Zero ;;
    - : nat = Suc Zero
    # sub (Suc (Suc Zero)) (Suc Zero);;
    - : nat = Suc Zero
    # sub Zero (Suc Zero);;
    Exception: Failure "sub".

Question 2
==========

Using OCaml's rational numbers library Num_ write a general purpose arbitrary precision `root-finding`_ function using any algorithm you choose (e.g. bisection_ or secant_). 

.. _Num: http://caml.inria.fr/pub/docs/manual-ocaml/libref/Num.html
.. _root-finding: https://en.wikipedia.org/wiki/Root_finding
.. _bisection: https://en.wikipedia.org/wiki/Bisection_method
.. _secant: https://en.wikipedia.org/wiki/Secant_method

The function  root : (Num.num -> Num.num) -> Num.num -> Num.num -> Num.num -> Num.num should take the following arguments: 

    ``f : Num.num -> Num.num`` is the function expressing the equation
    ``a : Num.num`` is the left endpoint of the interval where the root lies
    ``b : Num.num`` is the right endpoint of the interval 
    ``err : Num.num`` is the margin of error we can tolerate

The function ``root`` should return a root ``r : Num.num`` that lies within the interval (``r``\ -\ ``err``, ``r``\ +\ ``err``). 

Note: The library Num is not loaded into the OCaml top-level. To load it you need to execute the following top-level commands::

    # #use "topfind";;
    # #require "num";;
    # open Num;;

Here is an example usage of the function root to find solutions to the equation (x-4)*(x-6)=0 with error 1/100 then with error 1/1000::

    val root : (Num.num -> Num.num) -> Num.num -> Num.num -> Num.num -> Num.num = <fun>
    # let r0 = num_of_int 4;;
    val r0 : Num.num = <num 4>
    # let r1 = num_of_int 6;;
    val r1 : Num.num = <num 6>
    # let f x = (x -/ r0) */ (x -/ r1) ;;
    val f : Num.num -> Num.num = <fun>
    # root f (num_of_int 5) (num_of_int 8) (num_of_int 1 // num_of_int 100);;
    - : Num.num = <num 5123/1024>
    # root f (num_of_int 5) (num_of_int 8) (num_of_int 1 // num_of_int 1000);;
    - : Num.num = <num 40963/8192>

Question 3
==========
      
Given a list of native int values correctly calculate its sum. If there is an order in which the elements can be added so that there is no overflow, that order is used. For example the sum of the list  [max_int, max_int, -max_int] should be Some max_int. In case of unavoidable overflow the function should return None.

Note: You are not allowed to use any arbitrary precision library but, for efficiency, you must operate directly on the native int type of OCaml. ::

    val add : int list -> int option = <fun>
    # let m = max_int;;
    val m : int = 4611686018427387903
    # let _ = add [m; -1; -m; 2; -m; 8; 9; m];;
    - : int option = Some 18
    # let _ = add [m; 1; m; -5];;
    - : int option = None
