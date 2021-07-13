#lang sicp

(#%provide make-term
           order
           coeff)

(define (make-term order coeff) 
  (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))