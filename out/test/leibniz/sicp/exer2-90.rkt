#lang sicp


(#%require "type.rkt")
(#%require "table.rkt")
(#%require "variable.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-polynomial-package.rkt")
;;test
(define a1 (make-dense-termlist '(1 2 0 3 -2 -5)))
(define a2 (make-sparse-termlist '((100 1) (2 2) (0 1))))
a1
a2
(first-term a1)
(first-term a2)
(rest-terms a1)
(rest-terms a2)
(define t1 (make-term 6 3.14))
(define t2 (make-term 3 2.14))
(adjoin-term t1 a1)
(adjoin-term t2 a1)
(adjoin-term t1 a2)
(adjoin-term t2 a2)
(the-empty-termlist a1)
(empty-termlist? a1)
(empty-termlist? a2)
