#lang sicp
(#%require "digital-logic.rkt")
(#%require "wire.rkt")
(#%require "agenda.rkt")

(define input (make-wire))
(define output (make-wire))

;;;test 1
; 'input:
; (get-signal input)
; 'output:
; (get-signal output)
; '===================
; (inverter input output)
; (propagate)
; '===================
; 'input:
; (get-signal input)
; 'output:
; (get-signal output)

;;;test2
(probe 'input input)
(set-signal! input 1)