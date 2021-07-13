#lang sicp

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (is_visited? x l)
  (cond ((null? l)
         false)
        ((eq? x (car l))
         true)
        (else (is_visited? x (cdr l)))))

(define t1 (list 'a 'b))
(define l1 (list (list 'a 'b) (list 'c 'd)))
(define t2 (list 'a 'b))
(define l2 (list t2 (list 'c 'd)))

; (is_visited? t1 l1)
; (is_visited? t2 l2)
(define (count-pairs x)
  (define visited '())
  (define (inner x)
    (cond ((is_visited? x visited)
           0)
          ((not (pair? x))
           0)
          (else (begin
                  (set! visited (cons x visited))
                  (+ (inner (car x))
                     (inner (cdr x))
                     1)))))
  (inner x))

(define z3 (list 'a 'b 'c))
(define z1 (list 'c))
(define z4 (cons 'a (cons z1 z1)))
(define z4_ (cons z1 z1))
(define z7  (cons z4_ z4_))
(define z-none (list 'a 'b 'c))
(set-cdr! (last-pair z-none) z-none)

(count-pairs z3)
(count-pairs z4)
(count-pairs z7)
(count-pairs z-none)