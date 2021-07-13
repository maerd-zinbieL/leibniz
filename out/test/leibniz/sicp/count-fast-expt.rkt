#lang sicp
;;; page 30,求fast-expt的计算步数
(define (even? n)
  (= (remainder n 2) 0))


(define (count-steps n)
  (cond ((= n 0) 0)
        ((= n 1) 0)
        ((even? n) (+ 1 (count-steps (/ n 2))))
        (else (+ 1 (count-steps (- n 1))))))


(define (find-n n)
  (display (count-steps n))
  (newline)
  (cond ((> n 0) (find-n (- n 1)))))


(find-n 13)
         