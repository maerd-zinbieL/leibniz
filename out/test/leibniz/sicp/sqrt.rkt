#lang sicp

#|
(define (average x y) (/ (+ x y) 2))

(define (square x) (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001))
 
(define (try guess x)
  (if (good-enough? guess  x)
       guess
       (try (improve guess x) x)))

(define (sqrt x) (try 1 x))
(display(sqrt 2))
|#
(define (sqrt x)
  (define (average x y) (/ (+ x y) 2))
  (define (square x) (* x x))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.0001))
  (define (try guess)
    (if (good-enough? guess)
         guess
         (try (improve guess))))
  (try 1))

(display(sqrt 2.0))