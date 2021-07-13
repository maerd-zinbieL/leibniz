#lang sicp

(define f
  (let ((pre1 0)
        (pre2 0))
    (lambda (x)
      (begin
        (set! pre2 pre1)
        (set! pre1 x)
        pre2))))
; (f 1)
; (f 0)
(+ (f 1) (f 0))