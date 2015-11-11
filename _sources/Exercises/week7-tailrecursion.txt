
**********************
Week 7: tail recursion
**********************

.. highlight:: ocaml

We first recapped what tail recursion is.

Then we recapped how to do ``sum`` tail-recursively, namely by writing a function ``sum'`` that accumulates the "sum so far": ``sum' xs n = n + sum xs``.

Then we recapped how to do ``rev`` tail-recursively, namely by writing a function ``revap`` that accumulates the "rev so far": ``revap xs ys = rev xs @ ys``.

Then we did ``duplicates``.

Dan wrote this on Facebook:

    A follow-on to Bram's tutorial where he started to discuss the dup function (which duplicates all elements in a list as in ``dup [1;2;3] = [1;1;2;2;3;3]``) and its tail-recursive implementation. Note that in a tail-recursive implementation the 'accumulator' where you store the result will grow to the left and the 'obvious' implementation of dup will end up with the list in reverse order::

        let rec dup' xxs = function 
        | [] -> xxs
        | x :: xs -> dup' (x :: x :: xxs) xs
            # dup' [] [1;2;3] ;;
        - : int list = [3; 3; 2; 2; 1; 1]

    The obvious solution is to simply reverse the list produced by dup'::

        let dup xs = xs |> dup' [] |> List.rev
        # dup [1;2;3;4] ;;
        - : int list = [1; 1; 2; 2; 3; 3; 4; 4]

    This may seem like wasteful and inefficient but remember that reversing a list, also a tail-recursive operation, is in fact very fast and dup will be quite efficient. Not as efficient as the non-tail-recursive implementation::

        let rec dupn = function
            | [] -> []
        | x :: xs -> x :: x :: dupn xs

    But in the same ballpark, with the advantage of tail recursion! ::

        (* benchmarking *)
        let rec mkrlist xs = function
        | 0 -> xs
        | n -> mkrlist (Random.bits () :: xs) (n-1)
        let bm f n =
        let l = mkrlist [] n in
        let t0 = Sys.time () in 
        let _ = f l in 
        let t1 = Sys.time () in
        print_float (t1 -. t0); print_newline ()
        # bm dupn 100000;;
        0.028933
        - : unit = ()
        # bm dup 100000;;
        0.037415
        - : unit = ()
        # bm dupn 1000000;;
        Stack overflow during evaluation (looping recursion?).
        # bm dup 1000000;;
        0.299246
        - : unit = ()

Bram added:

    Great explanation, thanks!

    To do it equation-style, ``dup'`` is doing ::

        dup' xxs ys = rev (dup ys) @ xxs

    and an example equation we have is ::

        dup' [1; 2; 3] [4; 5; 6]
        = rev (dup [4; 5; 6]) @ [1; 2; 3]
        = rev (4 :: 4 :: dup [5; 6]) @ [1; 2; 3]
        = rev ([4; 4] @ dup [5; 6]) @ [1; 2; 3]
        = rev (dup [5; 6]) @ [4; 4] @ [1; 2; 3]
        = rev (dup [5; 6]) @ [4; 4; 1; 2; 3]
        = rev (dup [5; 6]) @ (4 :: 4 :: [1; 2; 3])
        = dup' (4 :: 4 :: [1; 2; 3]) [5; 6]

    so we know ::

        dup' xxs (y::ys) = dup' (y :: y :: xxs) ys

    and this is how Dan made the tail-recursive implementation of ``dup'``. To find ``dup xs`` for any ``xs``, just compute ``rev (dup xs) @ []`` which is just ``rev (dup xs)``, and re-reverse the result.

    As with sum and rev in the tutorial, we first make a more complicated version (``sum'``, ``revap``, ``dup'``) so we can make an efficient version of the simple thing (``sum``, ``rev``, ``dup``).

    Note: the arguments are in a different order than in the actual tutorial, I think.