#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%provide make-rational)

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  (define (addd x y z) 
       (make-rat (+ (* (numer x) (denom y) (denom z))
                    (* (denom x) (numer y) (denom z))
                    (* (denom x) (denom y) (numer z)))
                 (* (denom x) (denom y) (denom z))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'denom '(rational) denom)
  (put 'numer '(rational) numer)
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'addd '(rational rational rational)
       (lambda (x y z) (tag (addd x y z))))
  (put 'equ? '(rational rational)
       (lambda (x y)
         (= (*(denom x) (numer y))
            (*(denom y) (numer x)))))
  (put '=zero? '(rational)
       (lambda (x)
         (= (numer x) 0)))
  (put 'negative '(rational)
       (lambda (x)
         (tag (make-rat
               (- (numer x))
               (denom x)))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

(install-rational-package)