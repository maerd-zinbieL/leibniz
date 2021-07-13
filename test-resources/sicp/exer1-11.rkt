#lang sicp
(define (f-recursive n)
  (if (< n 3) n
      (+ (f-recursive (- n 1))
         (* 2 (f-recursive (- n 2)))
         (* 3 (f-recursive (- n 3))))
      )
)

(define (f-iter n)
  (define (iter a b c count)
    (if (= count 0) c
        (iter b c (+ (* 3 a) (* 2 b) c) (- count 1))))
  (if (< n 3) n
      (iter 0 1 2 (- n 2))))

(f-recursive 5)
(f-iter 5)
(f-recursive 8)