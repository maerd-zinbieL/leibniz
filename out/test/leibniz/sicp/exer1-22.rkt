#lang sicp

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

(define (timed-prime-test n)
  (define (report-prime elapsed-time)
    ;;; (newline)
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

(define (search-for-primes start end)
  (define (even? a)
    (= (remainder a 2) 0))

  (define (iter start_odd end_odd)
    (timed-prime-test start_odd)
    (cond ((< start_odd end_odd )
           (iter (+ start_odd 2) end_odd))))

  (define (next-odd a)
    (if (even? a)
        (+ a 1)
        a))
  (define (previous-odd a)
    (if (even? a)
        (- a 1)
        a))
  (iter (next-odd start) (previous-odd end)))
      
(define (3-smallest-primes n)
  (define (next-odd a)
    (if (even? a)
        (+ a 1)
        a))

  (define (find-index count n_odd)
    (if (= 3 count)
        (- n_odd 2)
        (if (prime? n_odd)
            (find-index (+ count 1) (+ 2 n_odd))
            (find-index count (+ 2 n_odd)))))

  (search-for-primes n (find-index 0 (next-odd n))))

  ;;; (search-for-primes n (find-index 0 (next-odd n))))

(define base 100000)

(3-smallest-primes (* base 10))
(newline)
(display "===============")
(3-smallest-primes (* base 100))
(newline)
(display "===============")
(3-smallest-primes (* base 1000))
(newline)
(display "===============")
(3-smallest-primes (* base 10000))