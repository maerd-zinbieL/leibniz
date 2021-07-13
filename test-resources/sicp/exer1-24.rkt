#lang sicp
;;; (define (random a)
;;;   (/ a 2))

(define (fast-prime? n times)
  (define (expmod base exp m)
    (define (square n) (* n n))
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder
            (square (expmod base (/ exp 2) m))
            m))
          (else
           (remainder
            (* base (expmod base (- exp 1) m))
            m))))
  (define (fermat-test n)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(define (prime? n)
  (define test-times 10)
  (fast-prime? n test-times))


(define (timed-prime-test n)
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))
  (define (start-prime-test start-time)
    (if (prime? n)
        (report-prime (- (runtime) 
                       start-time))))
  (cond ((prime? n)
         (newline)
         (display n)
         (start-prime-test (runtime)))))
  ;;; (newline)
  ;;; (display n)
  ;;; (start-prime-test (runtime)))



(timed-prime-test 1000003)
(timed-prime-test 1000033)
(timed-prime-test 1000037)

(timed-prime-test 10000019)
(timed-prime-test 10000079)
(timed-prime-test 10000103)

(timed-prime-test 100000007)
(timed-prime-test 100000037)
(timed-prime-test 100000039)

(timed-prime-test 1000000007)
(timed-prime-test 1000000009)
(timed-prime-test 1000000021)


