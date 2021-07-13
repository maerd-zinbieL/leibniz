#lang sicp

(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (max (car interval) (cdr interval)))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define (make-center-percent c p)
  (let ((width (abs (* c (/ p 100)))))
    (make-interval (- c width) (+ c width))))

(define (percent i)
  (let ((width (/ (-(upper-bound i)
                    (lower-bound i))
                  2))
        (center (abs (/ (+ (upper-bound i)
                           (lower-bound i))
                        2))))
    (* 100 (/ width (abs center)))))
    