#lang sicp

(define (average-damp f)
  (lambda (x) (/ (+ x (f x)) 2)))

(define (fixed-point f first-guess)
  ;;; 收敛：收敛值
  ;;; 否则：false
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define converge-step 1000)
  (define (try guess step)
    (let ((next (f guess)))
      (cond ((> step converge-step)
             false)
            ((close-enough? guess next)
             next)
           (else (try next (+ step 1))))))
  (try first-guess 1))

(define (repeated f n)
  (define (repeated-rec f n)
    (define (compose f g)
      (lambda (x)
        (f (g x))))
    (if (= 1 n)
        f
        (compose f (repeated-rec f (- n 1)))))
  (repeated-rec f n))

(define (log2-ceiling n)
  (define (iter i)
    (if (> (expt 2 (+ 1 i)) n)
        i
        (iter (+ i 1))))
  (iter 0))

(define (n-sqrt n x)
  (define repeat-times (log2-ceiling n) )
  (let ((n-formula
         (lambda (y) (/ x (expt y (- n 1)))))
        (average-damp-repeated
         (repeated average-damp repeat-times)))
    (fixed-point (average-damp-repeated n-formula) 1.0)))

(define (check n x)
  (display (n-sqrt n x))
  (newline)
  (display (expt x (/ 1 n)))
  (newline)
  (display "++++++++++++++++++++++")
  (newline))

(define (checks n)
  (check n 2)
  (check n 12)
  (check n 71)
  (check n 100)
  (check n 10)
  (check n 200))

(checks 100)