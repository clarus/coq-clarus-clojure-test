(* Basic integer computations. *)
Extraction Language Clojure.

Definition twelve : nat := 2 * 5 + 2.

Definition main := Nat.eqb twelve 12.
Extraction "extraction" main.