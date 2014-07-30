(* Basic sequential monad. *)
Require Import Coq.Lists.List.
Require Import Coq.Strings.String.

Definition M (A : Type) : Type :=
  list string -> A * list string.

Definition ret {A : Type} (x : A) : M A :=
  fun outputs => (x, outputs).

Definition bind {A B : Type} (x : M A) (f : A -> M B) : M B :=
  fun outputs =>
    let (x, outputs) := x outputs in
    f x outputs.

Notation "'let!' X ':=' A 'in' B" := (bind A (fun X => B))
  (at level 200, X ident, A at level 100, B at level 200).

Definition print (message : string) : M unit :=
  fun outputs => (tt, message :: outputs).

(* Extraction. *)
Extraction Language Clojure.

Extract Constant ret => "(fns [_ x] x)".
Extract Constant bind => "(fns [_ _ x f] (f x))".
Extract Constant print => "println".

(* Example. *)
Definition eval_outputs (A : Type) (program : unit -> M A) : list string :=
  snd (program tt nil).

Definition hello_world (_ : unit) : M bool :=
  let! _ := print "Hello world!" in
  ret true.

Compute eval_outputs _ hello_world.