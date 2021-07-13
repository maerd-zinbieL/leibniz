#lang sicp

(define (make-interval a b) (cons a b)) 
(define (upper-bound interval)
  (max (car interval) (cdr interval))) 
(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define (sub-interval interval1 interval2)
  (make-interval (- (lower-bound interval1) (upper-bound interval2))
                 (- (upper-bound interval1) (lower-bound interval2))))

(define (print-interval interval)
  (display "[ ")
  (display (lower-bound interval))
  (display " ")
  (display (upper-bound interval))
  (display "]")
  (newline))

(define interval1 (make-interval -1 2))
(define interval2 (make-interval 1 2))
(print-interval (sub-interval interval1 interval2))