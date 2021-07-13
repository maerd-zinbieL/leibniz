#lang sicp

;;; 迭代计算斐波那契数列第n项
(define (fib-iter n)
  (define (iter a b count)
    (if (= count 0)
        b
        (iter (+ a b) a (- count 1))))
  (iter 1 0 n))

;;; 使用通项公式计算斐波那契数列第n项
(define (fib-formula n)
  (define (formula alpha beta)
    (/ (- (expt beta n)
          (expt (- alpha) n))
       (+ alpha beta)))
  (define alpha (/ (- (sqrt 5) 1)
                   2))
  (define beta (/ (+ (sqrt 5) 1 )
                  2))
  (formula alpha beta))

;;; 递归计算斐波那契数列前n项和
(define (fib-sum-rec n)
  (if (= n 0)
      0
      (+ (fib-sum-rec (- n 1)) (fib-iter n))))

;;; 迭代计算斐波那契数列前n项和
(define (fib-sum-iter n)
  (define (iter sum count)
    (if (= n (- count 1))
        sum
        (iter (+ (fib-iter count) sum) (+ count 1))))
  (iter 0 0))

;;; 使用公式计算斐波那契数列前n项和
(define (fib-sum-formula n)
  (define (formula alpha beta)
    (/ (+ (/ (- (expt beta n) 1)
             (- beta 1))
          (* alpha (fib-formula n)))
       (+ alpha 1)))
  (define alpha (/ (- (sqrt 5) 1)
                   2))
  (define beta (/ (+ (sqrt 5) 1 )
                  2))
  (formula alpha beta))

