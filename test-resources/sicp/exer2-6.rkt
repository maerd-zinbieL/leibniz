#lang sicp

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;;; (add-1 zero)
;;; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
;;; (lambda (f) (lambda (x) (f ((lambda (f) f)x))))
;;; (lambda (f) (lambda (x) (f x )))
(define one (lambda (f) (lambda (x) (f x))))

;;; (add-1 one)
;;; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
;;; (lambda (f) (lambda (x) (f ((lambda (x) (f x))x))))
;;; (lambda (f) (lambda (x) (f (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

(define (add-2 n)
  ;;; (add-1 (add-1 n))
  ;;; (add-1 (lambda (f) (lambda (x) (f ((n f) x)))))
  ;;; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f ((n f) x)))) f) x))))
  ;;; (lambda (f) (lambda (x) (f ((lambda (x) (f ((n f) x)))x))))
  (lambda (f) (lambda (x) (f (f ((n f) x)))))
)

(define (add-3 n)
  (lambda (f) (lambda (x) (f (f (f ((n f) x)))))))

(define (add a b)
  ;;; (add-b a)
  (lambda (f) (lambda (x) ((b f)((a f) x)))))

(define (square n)
  (* n n))
  
;;; (((add-1 zero)square) 2)
;;; ((two square) 2)
;;; (((add two one) square) 3)
;;; (((add-2 one) square) 2)
;;; (((add-3 zero) square) 2)
(define (chruch-num->int chruch-num)
  ((chruch-num (lambda (x) (+ x 1))) 0))

(define (int->chruch-num n)
  (if (= 0 n)
      zero
      (add-1 (int->chruch-num (- n 1)))))

(chruch-num->int zero)
(((int->chruch-num 3) square) 2)