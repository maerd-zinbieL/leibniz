#lang sicp

(#%require "binary-tree.rkt")
(#%provide tree->list)

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append 
       (tree->list-1 
        (left-branch tree))
       (cons (entry tree)
             (tree->list-1 
              (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list 
         (left-branch tree)
         (cons (entry tree)
               (copy-to-list 
                (right-branch tree)
                result-list)))))
  (copy-to-list tree '()))

(define t (make-tree 4
           (make-tree 2
                      (make-tree 1
                                 '()
                                 '())
                      (make-tree 3
                                 '()
                                 '()))
           (make-tree 6
                      (make-tree 5
                                 '()
                                 '())
                      (make-tree 7
                                 '()
                                 '()))))
(define tree->list tree->list-2)
; (tree->list t)