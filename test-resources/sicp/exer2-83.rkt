#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")

(put 'raise '(scheme-number)
     (lambda (x) (make-rational x 1)))
(put 'raise '(rational)
     (lambda (x) (make-real (/ ((get 'numer '(rational)) x)
                               ((get 'denom '(rational)) x)))))
(put 'raise '(real)
     (lambda (x) (make-complex-from-real-imag x 0)))

(define (raise x)
  (let ((proc (get 'raise (list (type-tag x)))))
    (if proc
        (apply-generic 'raise x)
        false)))

;;;test

(define a1 (make-scheme-number 42))
(define a2 (make-rational 3 4))
(define a3 (make-real 2.14))
(define a4 (make-complex-from-real-imag 2 5))

(raise a1)
(raise a2)
(raise (make-scheme-number 3))

