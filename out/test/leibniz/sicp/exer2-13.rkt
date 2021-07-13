#lang sicp
(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (max (car interval) (cdr interval)))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define (make-center-percent c p)
  (let ((width (abs (* c (/ p 100)))))
    (make-interval (- c width) (+ c width))))

(define (center i)
  (/ (+ (lower-bound i) 
        (upper-bound i)) 
     2))

(define (percent i)
  (let ((width (/ (-(upper-bound i)
                    (lower-bound i))
                  2))
        (center (abs (/ (+ (upper-bound i)
                           (lower-bound i))
                        2))))
    (* 100 (/ width (abs center)))))

(define (mul-center-percent cp1 cp2)
  (let ((c1 (center cp1))
        (c2 (center cp2))
        (p1 (percent cp1))
        (p2 (percent cp2)))
    (make-center-percent (+ (* c1 c2)
                            (/ (* c1 c2 p1 p2) 10000))
                         (/ (+ p1 p2)
                            (+ (/ (* p1 p2) 10000) 1)))))

(define cp1 (make-center-percent 10 1.0))
(define cp2 (make-center-percent 100 1.0))

(percent (mul-center-percent cp1 cp2))
(+ (percent cp1) (percent cp2))