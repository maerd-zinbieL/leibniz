#lang sicp
;;; #lang racket/load

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g ((if (< d 0) - +) (gcd n d)))) 
     (cons (/ n g) (/ d g))))
;;;   (let ((g (gcd n d)))
;;;     (if (< (* n d) 0)
;;;         (cons (-(abs (/ n g))) (abs (/ d g)))
;;;         (cons (abs (/ n g)) (abs (/ d g))))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

 (print-rat (make-rat 6 9)) 
 (print-rat (make-rat -6 9))
 (print-rat (make-rat 6 -9))
 (print-rat (make-rat -6 -9))
