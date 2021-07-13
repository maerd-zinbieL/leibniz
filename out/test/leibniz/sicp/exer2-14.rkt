#lang sicp

(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (max (car interval) (cdr interval)))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) 
                    (lower-bound y))
                 (+ (upper-bound x) 
                    (upper-bound y))))

(define (sub-interval interval1 interval2)
  (make-interval (- (lower-bound interval1) (upper-bound interval2))
                 (- (upper-bound interval1) (lower-bound interval2))))

(define (print-interval interval)
  (display "[")
  (display (lower-bound interval))
  (display ",")
  (display (upper-bound interval))
  (display "]")
  (newline))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) 
               (lower-bound y)))
        (p2 (* (lower-bound x) 
               (upper-bound y)))
        (p3 (* (upper-bound x) 
               (lower-bound y)))
        (p4 (* (upper-bound x) 
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (<= (* (upper-bound y) (lower-bound y)) 0)
      (error "error, divide by an interval that spans zero." )
      (mul-interval x 
                    (make-interval 
                      (/ 1.0 (upper-bound y)) 
                      (/ 1.0 (lower-bound y))))))

(define (make-center-percent c p)
  (let ((width (abs (* c (/ p 100)))))
    (make-interval (- c width) (+ c width))))

(define (center i)
  (/ (+ (lower-bound i) 
        (upper-bound i)) 
     2))

(define (percent i)
  (let ((width (/ (- (upper-bound i)
                    (lower-bound i))))
        (center (abs (/ (+ (upper-bound i)
                           (lower-bound i))
                        2))))
    (* 100 (/ width (abs (center i))))))

(define (par1 r1 r2)
  (div-interval 
   (mul-interval r1 r2)
   (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval 
     one
     (add-interval 
      (div-interval one r1) 
      (div-interval one r2)))))

(define (par-correct r1 r2)
  (define (compute r1 r2)
    (/ 1 (+ (/ 1 r1) (/ 1 r2))))
  (let ((min-r1 (lower-bound r1))
        (min-r2 (lower-bound r2))
        (max-r1 (upper-bound r1))
        (max-r2 (upper-bound r2)))
    ;;; (display min-r1)
    ;;; (newline)
    ;;; (display min-r2)
    ;;; (newline)
    ;;; (display max-r1)
    ;;; (newline)
    ;;; (display max-r2)
    ;;; (newline)
    ;;; (display (compute min-r1 min-r2))
    ;;; (newline)
    ;;; (display (compute max-r1 max-r2))
    ;;; (newline)
    (make-interval (compute min-r1 min-r2)
                   (compute max-r1 max-r2))))

(define r1-int (make-interval 45.0 55.0))
(define r2-int (make-interval 4.5 5.5))

(define r1-cp (make-center-percent 50.0 10))
(define r2-cp (make-center-percent 5.0 10))

;;; 对于同一个代数表达式，区间表示和中心-百分比表示计算出来的结果一样
;;; (print-interval (par1 r1-int r2-int))
;;; (print-interval (par1 r1-cp r2-cp))
;;; (display "++++++++++++++++++++++++++++++++")
;;; (newline)
;;; (print-interval (par2 r1-int r2-int))
;;; (print-interval (par2 r1-cp r2-cp))

(print-interval (div-interval r1-int r1-int))
(print-interval (div-interval r1-int r2-int))
(display "+++++++++++++++++++++++++++++++++++")
(newline)
(print-interval (div-interval r1-cp r1-cp))
(print-interval (div-interval r1-cp r2-cp))
;;; (print-interval 
;;; (print-interval (par-correct r1-int r2-int))
;;; (newline)
;;; (display "++++++++++++++++++++++++++++++")
;;; (newline)
;;; (print-interval (par-correct r1-cp r2-cp))
;;; (newline)
;;; (display "++++++++++++++++++++++++++++++")
;;; (newline)

;;; (par1 r1-int r2-int)
;;; (print-interval (par2 r1-int r2-int))
;;; (newline)
;;; (par1 r1-cp r2-cp)
;;; (par2 r1-cp r2-cp)
;;; (display "+++++++++++++++++++++++++++++")
;;; (newline)
;;; (print-interval (div-interval r1-int r1-int))
;;; (print-interval (div-interval r1-int r2-int))
;;; (newline)
;;; (print-interval (div-interval r1-cp r1-cp))
;;; (print-interval (div-interval r1-cp r2-cp))
