#lang sicp

(define (make-segment point-start ponit-end)
  (cons point-start ponit-end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

 (define (average-points a b) 
   (make-point (/ (+ (x-point a) (x-point b))
                  2) 
               (/ (+ (y-point a) (y-point b))
                  2))) 
  
 (define (midpoint-segment seg) 
   (average-points (start-segment seg) 
                   (end-segment seg))) 

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(print-point (midpoint-segment
              (make-segment
               (make-point 5 6)
               (make-point 3 4))))