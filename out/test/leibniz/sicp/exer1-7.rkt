#lang sicp
(define (good-enough? guess x)
  (define (square x) (* x x))
  (< (abs (- (square guess) x)) 0.001))
(good-enough? 0.001 0.002)