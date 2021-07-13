#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-polynomial-package.rkt")

; (make-scheme-number 42)
; (negative (make-scheme-number 42))
; (make-rational 13 27)
; (negative (make-rational 13 27))
; (make-real 3.14159)
; (negative (make-real 3.14159))
; (make-complex-from-real-imag 3.5 -32)
; (negative (make-complex-from-real-imag 3.5
;                                        -32))

(define inner-poly (make-polynomial 
                      'y
                      (make-sparse-termlist
                       (list (list 3 (make-complex-from-real-imag 3.5 -32))
                             (list 2 (make-rational 5 2))
                             (list 1 (make-rational -3 2))
                             (list 0 (make-scheme-number 42))))))
  ; inner-poly
; (negative inner-poly)
(define outer-poly (make-polynomial
                      'x
                      (make-sparse-termlist
                       (list (list 4 (make-rational 7 2))
                             (list 3 (make-complex-from-real-imag 42 -13))
                             (list 2 inner-poly)
                             (list 0 (make-scheme-number 5))))))
; outer-poly
; (negative outer-poly)

(sub (make-polynomial 'x
                      (make-sparse-termlist
                       (list (list 4 (make-scheme-number 4))
                             (list 2 (make-scheme-number 2))
                             (list 0 (make-scheme-number 1)))))
     (make-polynomial 'x
                      (make-sparse-termlist
                       (list (list 4 (make-scheme-number 5))
                             (list 3 (make-scheme-number 4))
                             (list 1 (make-scheme-number 1))
                             (list 0 (make-scheme-number 1))))))
; (polynomial x (4 (integer . -1))
;               (3 (integer . -4))
;               (2 (integer . 2))
;               (1 (integer . -1)))