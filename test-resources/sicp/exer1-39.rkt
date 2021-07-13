#lang sicp

(define (cont-frac-rec n d k combiner)
  (define (rec i)
    (cond ((= i k) (/ (n k) (d k)))
          (else (/ (n i)
                   (combiner  (d i) (rec (+ i 1)))))))
  (rec 1))

(define (cont-frac-iter n d k combiner)
  (define (iter i res)
    (if (= i 1)
        res
        (iter (- i 1) (/ (n (- i 1)) (combiner (d (- i 1)) res)))))
  (iter k (/ (n k) (d k)))) 
         

(define (cont-frac n d k combiner)
  (cont-frac-iter n d k combiner))
;;;   (cont-frac-rec n d k combiner))

(define (tan-cf x k)
  (define (N i)
    (define (square a)
      (* a a))
    (if (= 1 i)
        x
        (square x)))
  (define (D i)
    (- (* 2 i) 1))
  (cont-frac N D k -))

(tan-cf 10.0 100)
(tan 10)