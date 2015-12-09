
*******************************
Week 11: exercises from week 10
*******************************

.. highlight:: ocaml

::

	let rec f xs n q = 
		if n = 0 then
			true
		else if n > 0 then
			(match xs with
			| [] -> false
			| y::ys -> 
				(* f ys (n-y) (enq y q) *)
				let n' = n - y in
				let xs' = ys in
				let q' = enq y q in
				f xs' n' q')
		else (* n < 0 *)
			let a, q' = deq q in
			let n' = n + a in
			let xs' = xs in
			f xs' n' q' ;;



	let findseg xs n = f xs n ([], []);;

http://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html

http://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html

