#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")
(#%require "install-number-package.rkt")

;;;test
(define a1 (make-scheme-number 42))
(define a2 (make-rational 3 1))
(define a3 (make-real 2.5))
(define a4 (make-real 2.0))
(define a5 (make-complex-from-real-imag 2.6 0))
(define a6 (make-complex-from-real-imag 7.0 0))

; (project a1)
; (project a2)
; (project a3)
; (project a4)
; (project a5)
; (project a6)

(drop a1)
(drop a2)
(drop a3)
(drop a4)
(drop a5)
(drop a6)
