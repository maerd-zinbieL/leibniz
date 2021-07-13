#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")
; (define (level type) 
;   (get 'level type)) 

; (define (install-level-package) 
;    (put 'level 'scheme-number 1) 
;    (put 'level 'rational 2) 
;    (put 'level 'real 3) 
;    (put 'level 'complex 4) 
;    'done) 
  
; (install-level-package) 

; (define (find-highest-type types)
;   (cond ((null? types) false)
;         ;  (error "empty type list"))
;         ((=(length types) 1) (car types))
;         (else
;          (let ((current (car types))
;                (remain (find-highest-type (cdr types))))
;            (if (> (level current) (level remain))
;                current
;                remain)))))

; (define (raise-one highest arg)
;   (if (equal? (type-tag arg) highest)
;       arg
;       (if (raise arg)
;           (raise-one highest (raise arg))
;           (error "no raise method for this type" arg))))

; (define (raise-all highest args)
;    (if (null? args)
;        '()
;        (cons (raise-one highest (car args)) (raise-all highest (cdr args)))))
          
; (define (apply-generic-2-84 op . args)
;      (let ((proc (get op (map type-tag args))))
;        (if proc
;            (apply proc (map contents args))
;            (let ((highest (find-highest-type (map type-tag args))))
;              (let ((new-args (raise-all highest args)))
;                (let ((proc (get op (map type-tag new-args))))
;                  (apply proc (map contents new-args))))))))

;;;test 1
(#%require "install-complex-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")
(#%require "install-raise-drop-package.rkt")

(define a1 (make-scheme-number 42))
(define a2 (make-rational 3 4))
(define a3 (make-real 2.14))
(define a4 (make-complex-from-real-imag 2 5))

(define test-list (list a1 a2 a3))

; (raise-all test-list)
;;; test 2

(define (addd a b c) (apply-generic 'addd a b c))
(addd a1 a2 a3)

(addd (make-real 3.14159) (make-rational 3 4) (make-complex-from-real-imag 1 7))
; (complex rectangular 4.89159 . 7)
(addd (make-rational 1 2) (make-rational 1 4) (make-rational 1 8))
; (rational 7 . 8)
(addd (make-scheme-number 42) (make-real 3.14159) (make-rational 2 5))
; (real . 45.54159)
(make-scheme-number 4)
(make-real 4.3)