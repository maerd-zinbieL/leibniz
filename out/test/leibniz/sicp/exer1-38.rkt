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
;;;   (cont-frac-iter n d k))
  (cont-frac-rec n d k))

(define d (lambda (i)
            (let ((r (remainder i 3)))
              (if (or (= 1 r) (= 0 r))
                  1
                  (* 2
                     (/ (+ i 1) 3))))))
(define e
  (+ 2
     (cont-frac (lambda (i) 1.0)
                d
             1000)))

(display e)