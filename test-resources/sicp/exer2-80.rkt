#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-rational-package.rkt")

(define (install-=zero?-package)
  (define numer (get 'numer '(rational)))
  (define magnitude (get 'my-magnitude '(complex)))
                                                        
  (put '=zero? '(scheme-number)
       (lambda (x)
         (= x 0)))
  (put '=zero? '(rational )
       (lambda (x)
         (= (numer x) 0)))
  (put '=zero? '(complex)
       (lambda (x y)
         (= (my-magnitude x) 0)))
  'done)

(install-=zero?-package)

(define (=zero? x y)
  (apply-generic '=zero? x y))

;;;test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
