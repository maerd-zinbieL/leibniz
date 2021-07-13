#lang sicp

(#%require "element-of-set.rkt")
(define (union-set set1 set2)
  (cond ((null? set1)
         set2)
        ((null? set2)
         set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else (cons (car set1)
                    (union-set (cdr set1) set2)))))

(define s1 '(1 2 3 1 5))
(define s2 '(2 5 8 6))

(union-set s1 s2)