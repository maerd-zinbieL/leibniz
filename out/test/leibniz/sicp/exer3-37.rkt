#lang sicp

(#%require "constraint.rkt")
(#%require "connector.rkt")

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c* x y)
   (let ((z (make-connector)))
     (multiplier x y z)
     z))

(define (c/ x y)
   (let ((z (make-connector))
         (one (make-connector))
         (1/y (make-connector)))
     (constant 1 one)
     (multiplier y 1/y one)
     (multiplier x 1/y z)
     z))

(define (cv v)
   (let ((z (make-connector)))
     (constant v z)
     z))

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)

(forget-value! C 'user)

(set-value! F 212 'user)