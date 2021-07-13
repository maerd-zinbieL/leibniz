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

(define (width-interval interval)
  (/ (- (upper-bound interval)
        (lower-bound interval))
     2))

(define (sub-add-combine-width width1 width2)
  (+ width1 width2))

(define (proof interval1 interval2)
  (let ((width-to-check (sub-add-combine-width
                         (width-interval interval1)
                         (width-interval interval2))))
    (and (= width-to-check
            (width-interval
             (add-interval interval1 interval2)))
         (= width-to-check
            (width-interval
             (sub-interval interval1 interval2))))))

(define interval1 (make-interval -1 2))
(define interval2 (make-interval 4 2))

(proof interval1 interval2)
;;; (width-interval interval1)
;;;  If the width of the result was a function of the widths of the inputs,
;;; then multiplying different intervals with the same widths should give the same answer