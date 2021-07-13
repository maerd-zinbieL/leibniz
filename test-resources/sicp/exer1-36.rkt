#lang sicp

(define tolerance 0.00001)

(define (step-print guess step)
  (display step)
  (display ": ")
  (display guess)
  (newline))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess step)
    (step-print guess step)
    (let ((next (f guess)))
      (cond ((close-enough? guess next)
             (step-print next step))
           (else (try next (+ step 1))))))
  (display "============================")
  (newline)
  (try first-guess 1))

(define (root-x-pow-x)
  (fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0))

(define (average-damp f)
  (lambda (x)
    (/ (+ x
          (f x)) 2)))

(define (root-x-pow-x-average-damp)
  (let ((formula (lambda (x) (/ (log 1000) (log x)))))
    (fixed-point (average-damp formula) 2.0)))

(root-x-pow-x-average-damp)