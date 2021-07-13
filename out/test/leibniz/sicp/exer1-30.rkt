#lang sicp
(define (cube x)
  (* x x x))

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
    (iter a 0))

(define (Integral-Simpson f a b n)
  (define h (/ (- b a) n))
  (define (y_k k)
    (f (+ a (* k h))))
  (define (even? k)
      (= (remainder k 2) 0))
  (define (sim-term k)
    (cond ((or (= k 0) (= k n))
           (y_k k))
          ((even? (- k 1))
           (* 4 (y_k k)))
          (else (* 2 (y_k k)))))
  (define (sim-next a)
    (+ a 1))
  (* (/ h 3)
     (sum sim-term 0 sim-next n)))

(Integral-Simpson cube 0 1 100)