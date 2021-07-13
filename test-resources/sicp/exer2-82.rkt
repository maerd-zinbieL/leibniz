#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")
;from http://community.schemewiki.org/?sicp-ex-2.82
; (define (apply-generic op . args) 
  
;      (define (type-tags args) 
;          (map type-tag args)) 
  
;      (define (try-coerce-to target) 
;          (map (lambda (x) 
;                  (let ((coercor (get-coercion (type-tag x) (type-tag target)))) 
;                      (if coercor 
;                          (coercor x) 
;                          x))) 
;               args)) 
      
;      (define (iterate next) 
;          (if (null? next)  
;              (error "No coersion strategy for these types " (list op (type-tags args))) 
;              (let ((coerced (try-coerce-to (car next)))) 
;                  (let ((proc (get op (type-tags coerced)))) 
;                      (if proc 
;                          (apply proc (map contents coerced)) 
;                          (iterate (cdr next))))))) 
  
;      (let ((proc (get op (type-tags args)))) 
;          (if proc 
;              (apply proc (map contents args)) 
;              (iterate args)))) 
  
 ; Situation where this is not sufficiently general: 
 ; types: A B C 
 ; registered op: (op some-A some-B some-B) 
 ; registered coercion: A->B C->B 
 ; Situation: Evaluating (apply-generic op A B C) will only try (op A B C), (op B B B) and fail  
 ; while we can just coerce C to B to evaluate (op A B B) instead 

(define (apply-generic op . args)
   (define (types args) (map type-tag args))
   (define (work? coercions)
      (if (null? coercions)
          true
          (and (car coercions)
              (work? (cdr coercions)))))
   (define (iter remain-types)
      (if (null? remain-types)
          (error "No coersion strategy for these types " (list op (types)))
          (let ((coercions
                 (map (lambda (type)
                        (if (equal? type (car remain-types))
                            (lambda (x) x)
                            (get-coercion type (car remain-types))))
                      (types args))))
            (if (work? coercions)
                ; (apply-generic op
                ;  (map (lambda (coercer arg)
                ;         (coercer arg))
                ;       coercions
                ;       args))
                (let ((new-args
                       (map (lambda (coercer arg)
                              (coercer arg))
                            coercions
                            args)))
                  (let ((proc (get op (types new-args))))
                    (apply proc new-args)))
                 
                (iter (cdr remain-types))))))
   (let ((proc (get op (types args)))) 
         (if proc 
             (apply proc (map contents args)) 
             (iter (types args)))))
;;;test
(#%require "install-complex-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-rational-package.rkt")
(define (addd x y z) (apply-generic 'addd x y z))

(define (scheme-number->complex n)
  (make-complex-from-real-imag 
   (contents n) 0))

(put-coercion 'scheme-number 'complex 
              scheme-number->complex)

(addd (make-scheme-number 1)
        (make-complex-from-real-imag 2 1)
        (make-scheme-number 3))
; ; (complex rectangular 6 . 1)
; (addd (make-complex-from-real-imag 1 2)
;         (make-scheme-number 3)
;         (make-complex-from-real-imag 4 5))
; (complex rectangular 8 . 7)
