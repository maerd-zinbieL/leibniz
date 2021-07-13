#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%require "install-polynomial-package.rkt")

(define d-L1 (make-dense-termlist '(1 0 0 0 0 -1)))
(define d-L2 (make-dense-termlist '(1 0 -1)))

(define s-L1 (make-sparse-termlist '((5 1) (0 -1))))
(define s-L2 (make-sparse-termlist '((2 1) (0 -1))))

(define d-p1 (make-polynomial 'x d-L1))
(define d-p2 (make-polynomial 'x d-L2))

(define s-p1 (make-polynomial 'x s-L1))
(define s-p2 (make-polynomial 'x s-L2))

d-p1
d-p2

s-p1
s-p2

(div d-p1 d-p2)
(div s-p1 s-p2)