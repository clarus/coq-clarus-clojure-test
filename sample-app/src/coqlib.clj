;;;; Clojure utility for extraction from Coq.
;;;; porting from http://www.pps.jussieu.fr/%7Eletouzey/scheme/
;;;;
;;;; Written by OOHASHI Daichi <dico.leque.comicron at gmail.com>
;;;; public domain.

(ns coqlib)

;;; currying
;;; (fns [a b] c) => (fn [a] (fn [b] c))
(defmacro fns [args & body]
  (if (empty? args)
    `(do ~@body)
    (let [[a & as] args]
      `(fn [~a] (fns ~as ~@body)))))

;;; calling curryed functions.
;;; (funcall f a b c) => (((f a) b) c)
(defmacro funcall [f a & args]
  (reduce (fn [f a]
            `(~f ~a))
          (list* f a args)))

;;; minimum pattern matching.
;;;
;;; When the first element of expr equals to the first element of pattern,
;;; rest elements of expr binds variables specified in the rest of pattern.
;;;
;;; ex. predecessor function.
;;; (defn pred [n] (match n ((:O) '(:O)) ((:S n) n)))
;;;
;;; Note. the first element of expr/pattern (= tag) should be keyword,
;;; not symbol, to avoid bothering with namespace.
(defmacro match [expr & cls]
  `(let [e# ~expr]
     (%match e# ~@cls)))

(defmacro %match [expr & cls]
  (if (empty? cls)
    `(error "match-failure")
    (let [[cl & rest] cls
          [[c & args] & body] cl]
      `(if (= (first ~expr) ~c)
         (let [[~@args] (rest ~expr)]
           ~@body)
         (%match ~expr ~@rest)))))

;;; letrec a la Scheme. only for functions.
(defmacro letrec [binds & body]
  `(letfn ~(map (fn [[name [_fn-or-fns [arg & args] & body]]]
                  `(~name [~arg]
                          ~@(if (empty? args)
                              body
                              `((fns ~args ~@body)))))
                binds)
     ~@body))

;;; error reporting
(defn error [msg]
  (throw (Exception. msg)))