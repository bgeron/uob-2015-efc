(* basic algo *)

let rec search
    (graph : (char * char * int) list)
    expand
    (fringe : char list)
    goal
    strategy
    visited
  = match fringe with
  | []                  -> None
  | n :: ns when goal n -> Some n
  | n :: ns             ->
    let fringe = strategy ns (expand n graph) (n :: visited) in
    search graph expand fringe goal strategy (n :: visited)

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

let goal n' n = (n = n')

let rec strategy fringe newnodes visited =
  let rec remove xs ys = match xs with
    | [] -> []
    | x :: xs ->
      if List.mem x ys
      then remove xs ys
      else x :: remove xs ys in 
  remove (newnodes @ fringe) visited


(* To use:

   search roadmap expand ['A'] (goal 'B') strategy [];;

 *)
