#lang sicp
(define (pass-fermat-test? n)
  (define (expmod base exp m)
    (define (square n)
      (* n n))
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder
            (square (expmod base (/ exp 2) m))
            m))
          (else
           (remainder
            (* base (expmod base (- exp 1) m))
            m))))
  (define (iter a n)
    (cond ((= a n) #t)
          ((= (expmod a n n) a ) (iter (+ a 1) n))
          (else #f)))
  (iter 1 n))


(define (prime? n)
  (define (square n) (* n n))
  (define (divides? a b)
    (= (remainder b a) 0))
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n)
           n)
          ((divides? test-divisor n)
           test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  (= n (smallest-divisor n)))


(define (not-prime? n)
  (not (prime? n)))


(define (not-prime-but-pass-fermat-test n)
  (and (not-prime? n) (pass-fermat-test? n)))


(define (find-carmichael end)
  (define (iter index end)
    (cond ((> index end) (display "done"))
          ((cond((not-prime-but-pass-fermat-test index)
                 (display index)
                 (newline)))
           (iter (+ index 2) end))))
  (iter 1 end))

(find-carmichael 100000000)