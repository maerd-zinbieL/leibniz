#lang sicp

(define (square n)
  (* n n))

; (define (square-tree t)
;   (cond ((null? t) '())
;         ((not (pair? t)) (square t))
;         (else (cons (square-tree (car t))
;                     (square-tree (cdr t))))))

; (define t (list (list 6 7)
;        5))
; (square-tree t)

; (cons (square-tree '(6 7))
;       (square-tree '(5)))

; (cons (cons (square-tree 6)
;             (square-tree '(7)))
;       (cons (square-tree 5)
;             (square-tree '())))

; (cons (cons 36
;             (cons (square-tree 7)
;                   (square-tree '())))
;       (cons 25
;             '()))

; (cons (cons 36
;             (cons 49
;                   '()))
;       (cons 25
;             '()))

(define (square-tree-map tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-map sub-tree)
             (square sub-tree)))
       tree))

(square-tree-map
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
; (1 (4 (9 16) 25) (36 49))