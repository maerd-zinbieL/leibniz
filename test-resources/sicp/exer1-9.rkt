#lang sicp

(define (+ a b)
  (if (= a 0) 
      b 
      (inc (+ (dec a) b))))
(define (inc x) (+ x 1))
(define (dec x) (- x 1))


(+ 4 5)

;;; (+ 4 5)
;;; (inc (+ 3 5))
;;; (inc (inc (+ 2 5)))
;;; (inc (inc (inc (+ 1 5))))
;;; (inc (inc (inc (inc (+ 0 5)))))
;;; (inc (inc (inc (inc 5))))
;;; (inc (inc (inc 6)))
;;; (inc (inc 7))
;;; (inc 8)


;;; (+ 4 5)
;;; (+ 3 6)
;;; (+ 2 7)
;;; (+ 1 8)
;;; (+ 0 9)


;;; (inc (+ (dec 4) 5))
;;; (inc (inc (+ (dec (dec 4)) 5)))
;;; (inc (inc (inc (+ (dec (dec (dec 4))) 5))))