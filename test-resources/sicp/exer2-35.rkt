#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x)
                         (cond ((null? x) 0)
                               ((pair? x)
                                (count-leaves x))
                               (else 1)))
                       t))) 

(define t '(1(2(3 4))))
(count-leaves t)