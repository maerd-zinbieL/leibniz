#lang sicp

(define (square x)
  (* x x))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated-rec f n)
  (if (= 1 n)
      f
      (compose f (repeated-rec f (- n 1)))))

(define (repeated-iter f n)
  (define (iter i repeated-f)
    (if (= 1 i)
        repeated-f
        (iter (- i 1) (compose f repeated-f))))
  (iter n f))

(define (repeated-lambda f n)
    (if (= n 1)
        f
        (lambda (x)
            (let ((fs (repeated f (- n 1))))
                (f (fs x))))))

(define (repeated-lambda-no-let f n)
  (if (= n 1)
   f
   (lambda (x)
     (f ( (repeated f(- n 1)) x) ))))

(define (repeated f n)
  (repeated-lambda-no-let f n))
  ;;; (repeated-lambda f n))
  ;;; (repeated-iter f n))
;;;   (repeated-rec f n))

((repeated square 5) 5)
(square(square(square(square(square 5)))))