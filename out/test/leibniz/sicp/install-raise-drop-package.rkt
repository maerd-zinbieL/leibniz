#lang sicp
(#%require "type.rkt")
(#%require "table.rkt")
(#%require "variable.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-polynomial-package.rkt")

(define (install-raise-drop-package)
   (put 'project '(complex)
       (lambda (c) (make-real
                    (my-real-part c))))
   (put 'project '(rational)
        (lambda (r) (make-scheme-number
                     (inexact->exact
                   (round
                    (/ ((get 'numer '(rational)) r)
                       ((get 'denom '(rational)) r)))))))
   (put 'project '(real)
        (lambda (r) (make-rational
                     (round r)
                     1)))
   
   (put 'raise '(scheme-number)
        (lambda (x) (make-rational x 1)))
   (put 'raise '(rational)
        (lambda (x) (make-real (/ ((get 'numer '(rational)) x)
                                  ((get 'denom '(rational)) x)))))
   (put 'raise '(real)
        (lambda (x) (make-complex-from-real-imag x 0)))
   'done)

(install-raise-drop-package)