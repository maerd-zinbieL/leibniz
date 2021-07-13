#lang sicp

(define rand-init 199)

(define (rand-update x) 
  (let ((a 27) (b 26) (m 127)) 
    (modulo (+ (* a x) b) m))) 

(define rand
  (let (( x rand-init))
    (define (dispatch m)
      (cond ((eq? m 'generate)
             (begin
               (set!  x (rand-update x))
               x))
            ((eq? m 'reset)
             (lambda (new-value)
               (set! x new-value)))
            (else (error "No method" m))))
    dispatch))

(rand 'generate)
(rand 'generate) 
(rand 'generate)
((rand 'reset) 199 100)
(rand 'generate) 
(rand 'generate)
(rand 'generate)
; (define x1 (rand-update rand-init))
; (define x2 (rand-update x1))
; (define x3 (rand-update x2))
; (define x4 (rand-update x3))
; (define x5 (rand-update x4))
; x1 x2 x3 x4 x5