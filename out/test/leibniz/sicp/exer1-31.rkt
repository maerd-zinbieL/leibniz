#lang sicp

(define (product-rec term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-rec term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a res)
    (if (> a b)
        res
        (iter (next a) (* (term a) res))))
  (iter a 1))

(define (product term a next b)
  ;;; (product-rec term a next b))
  (product-iter term a next b))

(define (factorial n)
  (define (identity x) x)
  (define (inc x) (+ 1 x))
  (product identity 1 inc n))

(define (pi-product n)
  (define (even? a)
    (= (remainder a 2) 0))
  (define (pi-term k)
    (if (even? k)
        (/ (+ k 2) (+ k 3))
        (/ (+ k 3) (+ k 2))))
  (define (inc k)
    (+ 1 k))
  (product pi-term 0 inc n))

(* (pi-product 10000) 4.0)

