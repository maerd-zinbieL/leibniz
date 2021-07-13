#lang sicp

(define (square x) (* x x))

(define (random-in-range low high) 
  (let ((range (- high low))) 
    (+ low (random range))))

(define (proc x1 x2 y1 y2)
  (let ((x0 (/ (+ x1 x2) 2))
        (y0 (/ (+ y1 y2) 2))
        (d (min (- x2 x1)
                (- y2 y1))))
    (lambda ()
      (let ((x (random-in-range x1 x2))
            (y (random-in-range y1 y2)))
        (<= (+ (square (- x x0))
               (square (- y y0)))
            (square (/ d 2)))))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (let ((area (* (- x2 x1) (- y2 y1))))
    (* area (monte-carlo trials (P x1 x2 y1 y2)))))
    
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) 
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) 
                 trials-passed))))
  (iter trials 0))

(exact->inexact
          (estimate-integral
           proc -1.0 1.0 -1.0 1.0 1000000))