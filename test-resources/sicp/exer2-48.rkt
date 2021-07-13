#lang sicp

(define (make-segment vect-start vect-end)
  (cons vect-start vect-end))

(define (start-segment segment)
  (ycor-vect (car  segment)))

(define (end-segment segment)
  (ycor-vect (cdr segment)))
