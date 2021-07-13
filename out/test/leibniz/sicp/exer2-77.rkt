#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")
(#%require "install-complex-package.rkt")

(define z1 (make-complex-from-real-imag  3 4))
(define z2 (make-complex-from-mag-ang (sqrt 2) (atan 1)))
(add z1 z2)
; (my-imag-part z2)
