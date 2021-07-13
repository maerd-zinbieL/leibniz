#lang sicp

(define (adjoin-set x set)
  (let ((x1 (car set)))
    (cond ((= x x1) set)
          ((< x x1) (cons x set))
          ((> x x1) (cons x1 (adjoin-set x (cdr set)))))))

(define s '(2 4 6 7 8))

(adjoin-set 3 s)