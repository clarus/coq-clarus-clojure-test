(* Print monad. *)
Require Import Coq.Lists.List.
Require Import Coq.Strings.String.

Extraction Language Clojure.

(** A dynamic type to represent any kind of output. *)
Module Dynamic.
  Definition t := {T : Type & T}.

  Definition make {A : Type} (x : A) : t :=
    existT _ A x.
End Dynamic.

Definition M (A : Type) : Type :=
  list Dynamic.t -> A * list Dynamic.t.

Definition ret {A : Type} (x : A) : M A :=
  fun outputs => (x, outputs).
Extract Constant ret => "(fns [x] x)".

Definition bind {A B : Type} (x : M A) (f : A -> M B) : M B :=
  fun outputs =>
    let (x, outputs) := x outputs in
    f x outputs.
Extract Constant bind => "(fns [x f] (f x))".

Notation "'let!' X ':=' A 'in' B" := (bind A (fun X => B))
  (at level 200, X ident, A at level 100, B at level 200).

Definition print (message : Dynamic.t) : M unit :=
  fun outputs => (tt, message :: outputs).
Extract Constant print => "println".

(* Example. *)
Definition eval_outputs (A : Type) (program : unit -> M A) : list Dynamic.t :=
  snd (program tt nil).

Definition hello_world (_ : unit) : M bool :=
  let! _ := print (Dynamic.make "Hello workd!" % string) in
  ret true.

(* Compute eval_outputs _ hello_world. *)

Definition main := hello_world tt.
Extraction "extraction" main.