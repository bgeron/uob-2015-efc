(* basic algo *)

(* Note that this version does *not* use 'visited'. So
   the type of 'strategy' is different.

 *)

let rec search
    (graph : (char * char * int) list)
    expand
    (fringe : char list)
    goal
    strategy
  = match fringe with
  | []                  -> None
  | n :: ns when goal n -> Some n
  | n :: ns             ->
    let fringe = strategy ns (expand n graph) in
    search graph expand fringe goal strategy

(* roadmap *)

let roadmap =
  [ ('A', 'Z', 75);  ('A', 'S', 140); ('A', 'T', 118);
	('T', 'L', 111); ('L', 'M', 70);  ('M', 'D', 75);
	('D', 'C', 120); ('C', 'R', 146); ('R', 'S', 80);
	('R', 'P', 97);  ('S', 'O', 151); ('O', 'Z', 71);
	('S', 'F', 99);  ('F', 'B', 211); ('B', 'P', 101);
	('P', 'C', 138); ('B', 'G', 90);  ('B', 'U', 85);
	('U', 'H', 98);  ('H', 'E', 86);  ('U', 'V', 142);
	('V', 'I', 92);  ('I', 'N', 87)]

let rec expand node = function
  | [] -> []
  | (n1, n2, _) :: edges when n1 = node ->
    n2 :: expand node edges
  | (n1, n2, _) :: edges when n2 = node ->
    n1 :: expand node edges
  | _ :: edges -> expand node edges

(* Different type from 'goal' in the second version! *)

let goal n = (n = 'A')

(* Different type from 'strategy' in the second version! *)

let strategy xs ys = xs @ ys;;


(* In the lecture:

  let rec strategy = append;;

Equivalently, we could have written:

  let strategy xs ys = append xs ys;;

or:

  let strategy xs ys = xs @ ys;;


(* To use:

   search roadmap expand ['A'] goal strategy;;

 *)
