#lang sicp
(#%require "digital-logic.rkt")
(#%require "wire.rkt")
(#%require "agenda.rkt")

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

(probe 'sum sum)
;sum 0  New-value = 0

(probe 'carry carry)
;carry 0  New-value = 0

(half-adder input-1 input-2 sum carry)
;ok

(set-signal! input-1 1)
;done

(propagate)
;sum 8  New-value = 1
;done

(set-signal! input-2 1)
;done

(propagate)
;carry 11  New-value = 1
;sum 16  New-value = 0
;done