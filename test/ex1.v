Extraction Language Clojure.

Definition twelve : nat := 2 * 5 + 2.
Recursive Extraction twelve.

Recursive Extraction Coq.Init.Peano.plus.

Module M.
  Definition f (A : Type) (x : A) : A :=
    x.
End M.
Definition zero := M.f _ 0.

Recursive Extraction zero.

Module N := M.

Recursive Extraction N.f.

Require Import Coq.Lists.List.
Recursive Extraction list_prod.

Require Import Coq.Reals.R_sqrt.
Recursive Extraction sqrt.