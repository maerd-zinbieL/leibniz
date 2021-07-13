#lang sicp

(#%require "constraint.rkt")
(#%require "connector.rkt")

(define (averager a b c)
  (let ((w (make-connector))
        (u (make-connector)))
    (constant 0.5 w)
    (adder a b u)
    (multiplier u w c)))

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(averager a b c)

(probe "a" a)
(probe "b" b)
(probe "c" c)

(define (check)
  (display "a: ")
  (display (get-value a))
  (display "    ")
  (display "b: ")
  (display (get-value b))
  (display "    ")
  (display "c: ")
  (display (get-value c))
  (newline))