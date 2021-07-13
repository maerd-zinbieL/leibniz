#lang sicp


(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define z3 (list 'a 'b 'c))
(define z1 (list 'c))
(define z4 (cons 'a (cons z1 z1)))
(define z4_ (cons z1 z1))
(define z7  (cons z4_ z4_))
(define z-none (list 'a 'b 'c))
(set-cdr! (last-pair z-none) z-none)

z-none

(count-pairs z3)
(count-pairs z4)
(count-pairs z7)
(count-pairs z-none)