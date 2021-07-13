#lang sicp

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated-rec f n)
  (if (= 1 n)
      f
      (compose f (repeated-rec f (- n 1)))))

(define (repeated f n)
  (repeated-rec f n))

(define (smooth f)
  (define dx 0.00001)
  (lambda (x)
    (/ (+ (f x)
          (f (- x dx))
          (f (+ x dx)))
       3)))

(define (smooth-n f n)
  (repeated (smooth f) n))

(define (square x)
  (* x x))

;;; ((smooth square ) 5)


(define (smooth-n-times f n)
    (let ((n-times-smooth (repeated smooth n)))
        (n-times-smooth f)))

((smooth-n square 3) 5)
 ((smooth-n-times square 3) 5)
 
  