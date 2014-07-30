(* Modules. *)
Extraction Language Clojure.

Module M.
  Definition f (A : Type) (x : A) : A :=
    x.
End M.

Module N := M.

Definition main := Nat.eqb (N.f _ 0) 0.

Extraction "extraction" main.