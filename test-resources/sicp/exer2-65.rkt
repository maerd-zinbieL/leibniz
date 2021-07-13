#lang sicp

(#%require "exer2-64.rkt")
(#%require "exer2-63.rkt")

(define (union-set set1 set2)
  (define (union-set-list  set1 set2)
    (cond ((null? set1)
           set2)
          ((null? set2)
           set1)
          (else (let ((x1 (car set1))
                      (x2 (car set2)))
                  (cond ((= x1 x2)
                         (cons x1
                               (union-set-list
                                          (cdr set1)
                                          (cdr set2))))
                        ((> x1 x2)
                         (cons x2
                               (union-set-list
                                          set1
                                          (cdr set2))))
                        (else (cons x1
                                    (union-set-list
                                               (cdr set1)
                                               set2))))))))
  (list->tree (union-set-list (tree->list set1)
                  (tree->list set2))))

(define (intersection-set set1 set2)
  (define (intersection-set-list set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1)) (x2 (car set2)))
          (cond ((= x1 x2)
                 (cons x1 (intersection-set-list
                           (cdr set1)
                           (cdr set2))))
                ((< x1 x2) (intersection-set-list
                            (cdr set1) 
                            set2))
                ((< x2 x1) (intersection-set-list
                            set1 
                            (cdr set2)))))))
  (list->tree (intersection-set-list (tree->list set1)
                         (tree->list set2))))

(define s1 (list->tree '(1 2 3 5 6 8 10 11)))
(define s2 (list->tree '(2 4 6 8 11 13)))
(tree->list (union-set s1 s2))
(tree->list (intersection-set s1 s2))