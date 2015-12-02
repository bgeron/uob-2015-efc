
*******************************************
Week 9: programming assignments from week 8
*******************************************

.. highlight:: ocaml

Q8.1
====

Question:

.. pull-quote::

    Write an OCaml function that will substitute all occurrences of an element in a list by a different element. The argument will have small-to-moderate size and performance considerations are not critical. ::

        # replace;;
        - : 'a -> 'a -> 'a list -> 'a list = <fun>
        # replace 2 0 [1;2;3;4;3;2;1];;
        - : int list = [1; 0; 3; 4; 3; 0; 1]

We found this in the tutorial::

    let rec replace a b l = match l with
      | [] -> []
      | x :: xs -> if x = a
                   then b :: (replace a b xs)
                   else x :: (replace a b xs)

Model solution: https://github.com/Duta/focs-2015-16/blob/master/solutions/week-8/exercise-1/wk8ex1.ml

Q8.2
====

Question:

.. pull-quote::

    Write an OCaml function that splits a list into list segments containing only identical elements. The function must work on small-to-moderate size lists. Performance of implementation is not critical. ::

        # split;;
        - : 'a list -> 'a list list = <fun>
        # split [1;2;2;3;3;3;4;4;5;6];;
        - : int list list = [[1]; [2; 2]; [3; 3; 3]; [4; 4]; [5]; [6]]
        # split [];;
        - : 'a list list = []
        # split [1];;
        - : int list list = [[1]]
        # split [1;2;3;3;2;2;1;1];;
        - : int list list = [[1]; [2]; [3; 3]; [2; 2]; [1; 1]]

We found this in the tutorial::

    let rec split l = match l with
          | [] -> []
          | x :: xs -> let ys = split xs in
                       match ys with
                       | [] -> [[x]]
                       | z :: zs -> if x = List.hd z then (x :: z) :: zs
                                    else [x] :: ys
                                ;;

Model solution: https://github.com/Duta/focs-2015-16/tree/master/solutions/week-8/exercise-2

Q8.3a
=====

Question:

.. pull-quote::

    You are given two lists that have as elements either integers or characters. The characters stand for variables of unknown values. You need to solve the following puzzle: Is there a way to give values to variables so that the two lists are equal? 

    For example [x, 1, x] and [3, y, 3] is solvable for x = 3 and y = 1 whereas [x, x, 0] and [1, 2, z] is not solvable. 

    Your task is to write an OCaml function that checks whether a puzzle is solvable or not.  ::

        type puzzle = K of int | U of char

        # solvable;;
        - : puzzle list -> puzzle list -> bool = <fun>

        # solvable [U 'x'; K 1; U 'x'] [K 3; U 'y'; K 3] ;;
        - : bool = true
        # solvable [U 'x'; U 'x'; K 0] [K 1; K 2; U 'z'];;
        - : bool = false

Model solution: https://github.com/Duta/focs-2015-16/tree/master/solutions/week-8/exercise-3a

----

**In the below solutions, I have fixed a bug since the tutorial.**

We found this in the tutorial::

    let rec solvable xs ys = match xs, ys with
      | [], [] -> true
      | [], (c :: cs) -> false
      | (b :: bs), [] -> false 
      | (b :: bs), (c :: cs) ->
          match b, c with
           | K b', K c' -> (b' = c') && (solvable bs cs)
           | U b', K c' -> solvable (replace (U b') (K c') bs) (replace (U b') (K c') cs)
           | K b', U c' -> solvable (replace (U c') (K b') bs) (replace (U c') (K b') cs)
           | U b', U c' -> solvable (replace (U b') (U c') bs) (replace (U b') (U c') cs);;

Alternatively, this::


    let rec solvable xs ys = match xs, ys with
      | [], [] -> true
      | [], (c :: cs) -> false
      | (b :: bs), [] -> false 
      | (b :: bs), (c :: cs) ->
          match b, c with
           | K b', K c' -> (b' = c') && (solvable bs cs)
           | U b', K c' -> solvable (replace (U b') c bs) (replace (U b') c cs)
           | K b', U c' -> solvable (replace (U c') b bs) (replace (U c') b cs)
           | U b', U c' -> solvable (replace (U b') c bs) (replace (U b') c cs);;

Alternatively, this::

    let rec solvable xs ys = match xs, ys with
      | [], [] -> true
      | [], (c :: cs) -> false
      | (b :: bs), [] -> false 
      | (b :: bs), (c :: cs) ->
          match b, c with
           | K b', K c' -> (b' = c') && (solvable bs cs)
           | U b', _ -> solvable (replace (U b') c bs) (replace (U b') c cs)
           | _, U c' -> solvable (replace (U c') b bs) (replace (U c') b cs);;

In a sense, this is nicer because we have fewer cases. But it's a matter of taste.

Alternatively, this::

    let rec solvable xs ys = match xs, ys with
      | [], [] -> true
      | [], (c :: cs) -> false
      | (b :: bs), [] -> false 
      | (b :: bs), (c :: cs) ->
          match b with
           | K b' -> (match c with 
                      | U c' -> solvable (replace (U c') (K b') bs) (replace (U c') (K b') cs)
                      | K c' -> b' = c' && (solvable bs cs))
           | U b' -> solvable (replace (U b') c bs) (replace (U b') c cs);;

(In the last program, I had to add parentheses around the inner match otherwise OCaml would think that ``| U b'`` belonged to the inner match.)