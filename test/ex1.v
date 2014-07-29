Extraction Language Clojure.

Definition twelve : nat := 2 * 5 + 2.
Recursive Extraction twelve.

(* Module M.
  Definition f (A : Type) (x : A) : A :=
    x.
End M.
Recursive Extraction M.f. *)