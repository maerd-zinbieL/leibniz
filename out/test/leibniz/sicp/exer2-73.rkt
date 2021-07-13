#lang racket

(require "type.rkt")
(require "table.rkt")

;;;b)
(define (install-sum-package)
  (define (make-sum a1 a2)
    (list '+ a1 a2))
  (define (addend content)
    (car content))
  (define (augend content)
    (cadr content))
  (define (sum-deriv exp var)
    (make-sum (deriv (addend exp)var)
              (deriv (augend exp) var)))
  
  ; (put 'deriv '(+) sum-deriv)
  (put 'deriv '+ sum-deriv)
  (put 'make-sum '+ make-sum))

(define (install-product-package)
  (define (make-product m1 m2)
    (list '* m1 m2))
  (define (multiplier content)
    (car content))
  (define (multiplicand content)
    (cadr content))
  (define (product-deriv exp var)
    (let ((new-exp-1 (multiplier exp))
          (new-exp-2 (multiplicand exp))
          (make-sum (get 'make-sum '+)))
      (make-sum
        (make-product new-exp-1
                      (deriv new-exp-1 var))
        (make-product new-exp-2
                      (deriv new-exp-2 var)))))


  ; (put 'deriv '(*) product-deriv)
  (put 'deriv '* product-deriv)
  (put 'make-product '* make-product))

;;;c)
(define (install-exponentiation-package)
  (define (make-exponentiation base exponent)
    (list '** base exponent))
  (define (exponentiation? x)
    (and (pair? x) (eq? (car x) '**)))
  (define (base content)
    (car content))
  (define (exponent content)
    (cadr content))
  (define (exponent-deriv exp var)
    (let ((make-product (get 'make-product '*)))
      (make-product
        (make-product
          (exponent exp)
          (make-exponentiation (base exp)
                               (- (exponent exp) 1)))
        (deriv (base exp) var))))

  ; (put 'deriv '(**) exponent-deriv)
  (put 'deriv '** exponent-deriv)
  (put 'make-exponentiation '** make-exponentiation))

;;;help procedures
 (define (variable? x) (symbol? x)) 
  
 (define (same-variable? v1 v2) 
   (and (variable? v1) 
        (variable? v2) 
        (eq? v1 v2))) 
  
 (define (=number? exp num) 
   (and (number? exp) (= exp num))) 
  
 (define (deriv exp var) 
    (cond ((number? exp) 0) 
          ((variable? exp)  
            (if (same-variable? exp var)  
                1  
                0)) 
          (else ((get 'deriv (operator exp))  
                 (operands exp)  
                 var)))) 

(define (operator exp) (car exp)) 
(define (operands exp) (cdr exp))

;;;test code
(install-sum-package)
(install-product-package)
(install-exponentiation-package)
(deriv '(* x x) 'x) 
(deriv '(+ x (* x  (+ x (+ y 2)))) 'x)
; (+ 1
;    (+
;       (* x 1)
;       (* (+ x
;             (+ y 2))
;          (+ 1
;             (+ 0 0)))))
(deriv '(** x 3) 'x) 

  