#lang sicp

(define (prime? n)
  (define (square n) (* n n))

  (define (divides? a b)
    (= (remainder b a) 0))

  (define (smallest-divisor n)
    (find-divisor n 2))

  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n)
           n)
          ((divides? test-divisor n)
           test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  
  (= n (smallest-divisor n)))

(prime? 4)