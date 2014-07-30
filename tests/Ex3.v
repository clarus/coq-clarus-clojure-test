(* Lists. *)
Require Import Coq.Lists.List.

Extraction Language Clojure.

Definition main := list_prod.

Extraction "extraction" main.