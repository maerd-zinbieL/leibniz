#lang sicp

(#%provide  apply-generic
            raise
            project
            drop
            equ?
            add sub div mul
            =zero? negative)

(#%require "type.rkt")
(#%require "table.rkt")

(define (level type) 
  (get 'level type)) 

(define (install-level-package) 
   (put 'level 'scheme-number 1) 
   (put 'level 'rational 2) 
   (put 'level 'real 3) 
   (put 'level 'complex 4) 
   'done) 
  
(install-level-package) 

(define (apply-generic op . args)
  (define (find-highest-type types)
    (cond ((null? types) false)
          ;  (error "empty type list"))
    ((=(length types) 1) (car types))
    (else
     (let ((current (car types))
           (remain (find-highest-type (cdr types))))
       (if (> (level current) (level remain))
           current
           remain)))))
  (define (raise-one highest arg)
    (if (equal? (type-tag arg) highest)
        arg
        (if (raise arg)
            (raise-one highest (raise arg))
            (error "no raising method for this type : RASIE-ONE"  arg))))
  (define (raise-all highest args)
    (if (null? args)
       '()
       (cons (raise-one highest (car args)) (raise-all highest (cdr args)))))
  (let ((proc (get op (map type-tag args))))
    (if proc
       (apply proc (map contents args))
       (let ((highest (find-highest-type (map type-tag args))))
         (let ((new-args (raise-all highest args)))
           (let ((proc (get op (map type-tag new-args))))
             (if proc
                 (drop (apply proc (map contents new-args)))
                 (error "no method for these type :"  (list op (map type-tag new-args))))))))))


(define (raise x)
  (let ((proc (get 'raise (list (type-tag x)))))
    (if proc
        (apply-generic 'raise x)
        false)))

(define (project x)
  (let ((proc (get 'project (list (type-tag x)))))
    (if proc
        (apply-generic 'project x)
        false)))

(define (drop x)
  (define (dropable? x)
    (and (project x)
         (equ? (raise (project x)) x)))
  (if (dropable? x)
      (drop (project x))
      x))

(define (equ? x y)
  (apply-generic 'equ? x y))

(define (=zero? x)
  (apply-generic '=zero? x))

(define (add a1 a2)
  (apply-generic 'add a1 a2))

(define (sub a1 a2)
  (apply-generic 'sub a1 a2))

(define (mul a1 a2)
  (apply-generic 'mul a1 a2))

(define (div a1 a2)
  (apply-generic 'div a1 a2))

(define (negative a)
  (apply-generic 'negative a))
