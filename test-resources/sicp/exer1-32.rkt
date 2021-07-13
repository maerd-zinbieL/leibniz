#lang sicp

(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-rec combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a res)
    (if (> a b)
        res
        (iter (next a) (combiner (term a) res))))
  (iter a null-value))

(define (accumulate  combiner null-value term a next b)
  (accumulate-iter  combiner null-value term a next b))
;;;   (accumulate-rec  combiner null-value term a next b))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))


;;; test code for sum
;;; (define (cube x)
;;;   (* x x x))

;;; (define (Integral-Simpson f a b n)
;;;   (define h (/ (- b a) n))
;;;   (define (y_k k)
;;;     (f (+ a (* k h))))
;;;   (define (even? k)
;;;       (= (remainder k 2) 0))
;;;   (define (sim-term k)
;;;     (cond ((or (= k 0) (= k n))
;;;            (y_k k))
;;;           ((even? (- k 1))
;;;            (* 4 (y_k k)))
;;;           (else (* 2 (y_k k)))))
;;;   (define (sim-next a)
;;;     (+ a 1))
;;;   (* (/ h 3)
;;;      (sum sim-term 0 sim-next n)))

;;; (Integral-Simpson cube 1 2 100)

;;; test code for product
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