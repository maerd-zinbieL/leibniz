#lang sicp

(define (equal? a b)
  (cond ((null? a)
         (if (null? b)
             true
             false))
        ((null? b)
         (if (null? a)
             true
             false))
        (else (let ((next-a (car a))
                    (next-b (car b)))
                (if (and (pair? next-a)
                         (pair? next-b))
                    (equal? (car a) (car b))
                    (and (eq? next-a next-b)
                         (equal? (cdr a) (cdr b))))))))

(equal? '(this is a list) 
        '(this is a list))
             
(equal? '(this is a list) 
        '(this (is a) list))
 (equal? '(1 2 3 (4 5) 6) '(1 2 3 (4 5) 6)) 
 ;Value: #t 
  
 (equal? '(1 2 3 (4 5) 6) '(1 2 3 (4 5 7) 6)) 
 ;Value: #f 