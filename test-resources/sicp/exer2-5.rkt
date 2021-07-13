#lang sicp

(define (get-exponent n divisor)
  (define (iter now res)
    (if (= (remainder now divisor) 0)
        (iter (/ now divisor) (+ 1 res))
        res))
  (iter n 0))
  
(define (my-cons a b) (* (expt 2 a) (expt 3 b))) 
(define (my-car z) (get-exponent z 2)) 
(define (my-cdr z) (get-exponent z 3)) 
  
(define test (my-cons 13 17)) 
(my-car test) 
(my-cdr test) 