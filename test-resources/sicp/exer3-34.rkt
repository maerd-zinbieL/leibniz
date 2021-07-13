#lang sicp

(#%require "constraint.rkt")
(#%require "connector.rkt")

(define (squarer a b) (multiplier a a b))

(define a (make-connector))
(define b (make-connector))

(squarer a b)

;;;test
(set-value! b 9 'user)
(get-value b)
(get-value a)
(has-value? a)