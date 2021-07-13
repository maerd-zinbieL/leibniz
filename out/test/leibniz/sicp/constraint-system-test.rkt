#lang sicp

(#%require "constraint.rkt")
(#%require "connector.rkt")

; (define C (make-connector))
; (define F (make-connector))

; (define (celsius-fahrenheit-converter c f)
;   (let ((u (make-connector))
;         (v (make-connector))
;         (w (make-connector))
;         (x (make-connector))
;         (y (make-connector)))
;     (multiplier c w u)
;     (multiplier v x u)
;     (adder v y f)
;     (constant 9 w)
;     (constant 5 x)
;     (constant 32 y)
;     'ok))

; (celsius-fahrenheit-converter C F)

; (probe "Celsius temp" C)
; (probe "Fahrenheit temp" F)

; (set-value! C 25 'user)

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(constant 23 a)
(define me (adder a b c))
(set-value! b 2 'user)
(get-value a)
(get-value b)
(get-value c)
'=====================
; (forget-value! a me)
(forget-value! b 'user)
(get-value a)
(get-value b)
(get-value c)
