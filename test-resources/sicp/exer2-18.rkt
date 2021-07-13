#lang sicp
(define (reverse items)
  (define (iter items res)
    (if (null? items)
        res
        (iter (cdr items) (cons (car items) res))))
  (iter items (list )))

(define a (list 1 2 3 34))
(reverse a)