#lang sicp

(define (fast-expt b n)
  (define (square n)
    (* n n))
  (define (even? n)
    (= (remainder n 2) 0))
  (define (iter a b counter)
    (cond ((= counter 0) a)
          ((even? counter) (iter a  (square b) (/ counter 2)))
          (else (iter (* a b) b (- counter 1)))))
  (iter 1 b n))

(fast-expt 2 5)
           