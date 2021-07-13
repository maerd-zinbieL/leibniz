#lang sicp

(#%provide make-tree
           datum
           children
           count-children
           add-child!
           leaf?
           preorder)

(define (make-tree datum . children)
  (cons datum children))

(define (add-child! tree child)
  (set-cdr! tree (append (children tree) (list child))))

(define (datum tree)
  (car tree))

(define (children tree)
  (cdr tree))

(define (count-children tree)
  (length (children tree)))

(define (leaf? node)
  (null? (children node)))

(define (preorder tree)
  (cond ((null? tree) '())
        ((pair? tree) (append (preorder (datum tree))
                              (preorder (children tree))))
        (else (list tree))))
  
; (define t (make-tree "*root*"))
; (add-child! t 'x)
; (add-child! t 'a)
; t
; (length (children t))