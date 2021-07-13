#lang sicp

(define (make-accumulator init)
  (lambda (a)
    (begin
      (set! init (+ init a))
      init)))

(define A (make-accumulator 5))

(A 10)
;15

(A 10)
;25