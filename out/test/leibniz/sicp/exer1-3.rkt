#lang sicp
(define (ex1.3 a b c)
   (if (< a b) (if (> a c) (+ a b) (+ b c))
       (if (> b c) (+ a b) (+ a c))
   )
)
(ex1.3 3.1 3.1 3)