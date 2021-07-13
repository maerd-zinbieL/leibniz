#lang sicp

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) 
            (append (cdr list1) 
                    list2))))

(define (fringe t)
  (define (iter t res)
    (cond ((null? t) res)
          ((pair? (car t)) (iter (cdr t) (append res (fringe (car t)) )))
          (else (iter (cdr t) (append res (list (car t)) )))))
  (iter t '()))

(define x 
  (list (list 1 2) (list 3 4)))

(fringe x)
; (1 2 3 4)

(fringe (list x x))
; (1 2 3 4 1 2 3 4)