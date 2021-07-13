#lang sicp
(define (even? a)
    (= (remainder a 2) 0))

(define (double a)
  (+ a a))

(define (half a)
  (define (iter res)
    (if (= (double res) a)
        res
        (iter (+ res 1))))
  (if (even? a) (iter 1)
      (error "invalid integer")))

(define counter 0)
(define (* a b )
  (set! counter (+ counter 1))
  (cond ((= b 1) a)
        ((even? b)
         (double (* a (half b) )))
        (else (+ a (* a (- b 1))))))

(* 3 32)
(newline)
(display counter)