#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)

(install-scheme-number-package)

(define a1 ((get 'make 'scheme-number) 2))
(define a2 ((get 'make 'scheme-number) 5))
(apply-generic 'add a1 a2)

(apply-generic 'add 2 5)