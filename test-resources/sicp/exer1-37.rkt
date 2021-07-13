#lang sicp

(define (cont-frac-rec n d k)
  (define (rec i)
    (cond ((= i k) (/ (n k) (d k)))
          (else (/ (n i)
                   (+  (d i) (rec (+ i 1)))))))
  (rec 1))

(define (cont-frac-iter n d k)
  (define (iter i res)
    (if (= i 1)
        res
        (iter (- i 1) (/ (n (- i 1)) (+ (d (- i 1)) res)))))
  (iter k (/ (n k) (d k)))) 
         

(define (cont-frac n d k)
  (cont-frac-iter n d k))
;;;   (cont-frac-rec n d k))

(define reciprocal-theta
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             100))

(/ 1 reciprocal-theta)