(* Lists. *)
Require Import Coq.Lists.List.

Extraction Language Clojure.

Definition l := List.map (fun n => n + 1) (1 :: 2 :: 3 :: nil).

Definition main := Nat.eqb (List.hd 15 l) 2.
Extraction "extraction" main.