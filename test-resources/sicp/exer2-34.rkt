#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
  (accumulate
   (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
   0
   coefficient-sequence))

(define (check x coefficient-sequence)
  (define n (length coefficient-sequence))
  (define (iter k cs res)
    (if(= k  n)
       res
       (iter (+ k 1)
             (cdr cs)
             (+ (* (car cs) (expt x k))
                res))))
  (iter 0 coefficient-sequence 0))

(horner-eval 2 (list 1 3 0 5 0 1))
(check 2 (list 1 3 0 5 0 1))

(horner-eval 5 (list 1 3 0 6 0 2))
(check 5 (list 1 3 0 6 0 2))