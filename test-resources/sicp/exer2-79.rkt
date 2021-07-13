#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")
(#%require "install-complex-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-rational-package.rkt")

(#%provide equ?)
(define (install-equ?-package)
  (define denom (get 'denom '(rational)))
  (define numer (get 'numer '(rational)))
  (define real-part (get 'real-part '(complex)))
  (define imag-part (get 'imag-part '(complex)))
  
  (define equ?-number (lambda (x y)
                          (= x y)))
  (define equ?-rational (lambda (x y)
                            (= (*(denom x) (numer y))
                               (*(denom y) (numer x)))))
  (define equ?-real (lambda (x y)
                      (= x y)))
  (define equ?-complex (lambda (x y)
                            (and (= (my-real-part x)
                                    (my-real-part y))
                                 (= (my-imag-part x)
                                    (my-imag-part y)))))
                                                        
  (put 'equ? '(scheme-number scheme-number) equ?-number)
  (put 'equ? '(rational rational) equ?-rational)
  (put 'equ? '(complex complex) equ?-complex)
  (put 'equ? '(real real) equ?-real)
  'done)

(install-equ?-package)

(define (equ? x y)
  (apply-generic 'equ? x y))

;;;test
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (equ? (make-scheme-number (/ 1 3)) 
;                (make-scheme-number (/ 1 3)))
; (equ? (make-rational 2 11) (make-rational 2 10))
; (equ? (make-complex-from-mag-ang 5 (asin 0.8))
;       (make-complex-from-real-imag 3 4))
; (equ? (make-rational 8.881784197001252e-16 1) (make-rational 0 1))
; (equ? (make-complex-from-mag-ang 5 2)  
;       (make-complex-from-mag-ang 5 (+ 2 (* 2 3.14159265358979))))