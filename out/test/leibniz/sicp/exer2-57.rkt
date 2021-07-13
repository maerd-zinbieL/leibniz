#lang sicp
;;;basic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

;;;product
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (define (make-product m1 m2)
;   (cond ((or (=number? m1 0) 
;              (=number? m2 0)) 
;          0)
;         ((=number? m1 1) m2)
;         ((=number? m2 1) m1)
;         ((and (number? m1) (number? m2)) 
;          (* m1 m2))
;         (else (list '* m1 m2))))
(define (make-product . l)
   (define (iter nums vars l)
    (cond ((null? l)
           (cond ((=number? nums 0) 0)
                 ((and (=number? nums 1) (not (= (length vars) 1)))
                  (append (list '*) vars))
                 ((and (=number? nums 1) (= (length vars) 1))
                  (car vars))
                 (else (append (list '*) (list nums) vars))))
          ((number? (car l))
           (iter (* (car l) nums) vars (cdr l)))
          (else (iter nums (append  vars (list (car l))) (cdr l)))))
   (iter 1 '() l))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))


;;; sum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (define (make-sum a1 a2)
;   (cond ((=number? a1 0) a2)
;         ((=number? a2 0) a1)
;         ((and (number? a1) (number? a2)) 
;          (+ a1 a2))
;         (else (list '+ a1 a2))))
(define (make-sum  . l)
  (define (iter nums vars l)
    (cond ((null? l)
           (cond ((and (=number? nums 0) (> (length vars) 1))
                  (append (list '+) vars))
                 ((and (=number? nums 0) (= (length vars) 1))
                  (car vars))
                 ((and (not (=number? nums 0)) (null? vars))
                  nums)
                 (else (append (list '+) (list nums) vars))))
          ((number? (car l))
           (iter (+ (car l) nums) vars (cdr l)))
          (else (iter nums (append  vars (list (car l))) (cdr l)))))
  (iter 0 '() l))

; (define (make-product m1 m2) (list '* m1 m2))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))


;;; exponention
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-exponentiation base exponent)
  (list '** base exponent))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base exponentiation)
  (cadr exponentiation))

(define (exponent exponentiation)
  (caddr exponentiation))

;;; deriv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product 
           (deriv (multiplier exp) var)
           (multiplicand exp))))
        ((exponentiation? exp)
         (make-product
          (make-product
           (exponent exp)
           (make-exponentiation (base exp)
                                (- (exponent exp) 1)))
          (deriv (base exp) var)))
        (else (error "unknown expression 
                      type: DERIV" exp))))

(define (length l)
   (if (null? l)
        0
        (+ 1 (length (cdr l)))))

(define (augend s)
   (if  (= (length s) 3)
        (caddr s)
        (append (list '+) (cdr (cdr s)))))
        
        
  ;  (accumulate make-sum 0 (cddr s))) 
  ;  (append (list '+) (cdr (cdr s))))

(define (multiplicand p)
  ;  (accumulate make-product 0 (cddr p))) 
     (if  (= (length p) 3)
        (caddr p)
        (append (list '*) (cdr (cdr p)))))

; (define s (make-product 1 3 'a 'b 'c))
; s
; (product? s)
; (multiplier s)
; (multiplicand s)

; (make-product 4 51 0 'a 'b 'v 'a)

(deriv '(* (* x y) (+ x 3)) 'x)
(deriv '(* x y (+ x 3)) 'x)