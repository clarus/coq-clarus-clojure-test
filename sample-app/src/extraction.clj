(ns Main
  (:use coqlib)
  (:refer-clojure
   :only [defmacro fn let reduce first rest println = load-file symbol?
          empty? list* lazy-seq]))

(def Coq-Init-Nat-add (fns [n m]
                                      (match n
                                         ((:Coq-Init-Datatypes-O) m)
                                         ((:Coq-Init-Datatypes-S p)
                                           `(:Coq-Init-Datatypes-S
                                           ~(funcall Coq-Init-Nat-add p m))))))
                                      
(def Coq-Init-Nat-mul (fns [n m]
  (match n
     ((:Coq-Init-Datatypes-O) `(:Coq-Init-Datatypes-O))
     ((:Coq-Init-Datatypes-S p)
       (funcall Coq-Init-Nat-add m (funcall Coq-Init-Nat-mul p m))))))
  
(def Ex1-twelve
  (funcall Coq-Init-Nat-add
    (funcall Coq-Init-Nat-mul `(:Coq-Init-Datatypes-S (:Coq-Init-Datatypes-S
      (:Coq-Init-Datatypes-O))) `(:Coq-Init-Datatypes-S
      (:Coq-Init-Datatypes-S (:Coq-Init-Datatypes-S (:Coq-Init-Datatypes-S
      (:Coq-Init-Datatypes-S (:Coq-Init-Datatypes-O)))))))
    `(:Coq-Init-Datatypes-S (:Coq-Init-Datatypes-S (:Coq-Init-Datatypes-O)))))

(def Ex1-main Ex1-twelve)

