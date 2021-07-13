#lang sicp

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
           (inverter
            (and-gate (inverter a1)
                      (inverter a2)))))
                     (set! output new-value)))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

;;;or-gate-delay = inverter-delay*2 + and-gate-delay