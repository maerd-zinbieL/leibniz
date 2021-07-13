#lang sicp
(define (last-pair items)
  (let ((next (cdr items)))
    (if (null? next)
        (car items)
        (last-pair next))))

(define a (list 1 2 3 34))
(last-pair a)
