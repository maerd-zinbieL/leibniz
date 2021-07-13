#lang sicp

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (average-points a b) 
  (make-point (/ (+ (x-point a) (x-point b))
                 2) 
               (/ (+ (y-point a) (y-point b))
                  2))) 
  
(define (midpoint-segment seg) 
  (average-points (start-segment seg) 
                  (end-segment seg))) 

(define (make-segment point-start ponit-end)
  (cons point-start ponit-end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

;;; (define (make-rect segment)
;;;   (let ((bottom-left-point
;;;          (make-point
;;;           (x-point (start-segment segment))
;;;           (y-point (start-segment segment ))))
;;;         (top-left-point
;;;          (make-point
;;;           (x-point (start-segment segment))
;;;           (y-point (end-segment segment))))
;;;         (top-right-point
;;;          (make-point
;;;           (x-point (end-segment segment))
;;;           (y-point (end-segment segment))))
;;;         (bottom-right-point
;;;          (make-point
;;;           (x-point (end-segment segment))
;;;           (y-point (start-segment segment)))))
;;;     (cons bottom-left-point
;;;           (cons top-left-point
;;;                 (cons top-right-point
;;;                       bottom-right-point)))))

(define (make-rect bottom-left-point width height)
  (let ((top-left-point
         (make-point
          (x-point bottom-left-point)
          (+ (y-point bottom-left-point) height)))
        (top-right-point
         (make-point
          (+ (x-point bottom-left-point) width)
          (+ (y-point bottom-left-point) height)))
        (bottom-right-point
         (make-point
          (+ (x-point bottom-left-point) width)
          (y-point bottom-left-point))))
    (cons bottom-left-point
          (cons top-left-point
                (cons top-right-point
                      bottom-right-point)))))

(define (bottom-left-rect rect)
  (car rect))

(define (top-left-rect rect)
  (car (cdr rect)))

(define (top-right-rect rect)
  (car (cdr (cdr rect))))

(define (bottom-right-rect rect)
  (cdr (cdr (cdr rect))))

(define (height-rect rect)
  (abs (- (y-point (top-left-rect rect))
          (y-point (bottom-left-rect rect)))))

(define (width-rect rect)
  (abs (- (x-point (bottom-left-rect rect))
          (x-point (bottom-right-rect rect)))))

(define (area-rect rect)
  (* (width-rect rect)
     (height-rect rect)))

(define (perimeter-rect rect)
  (* 2
     (+ (width-rect rect)
        (height-rect rect))))

;;; (define rect (make-rect
;;;               (make-segment
;;;                (make-point 0 0)
;;;                (make-point 3 4))))

(define rect (make-rect
              (make-point 0 0)
              3
              4))

(bottom-left-rect rect)
(top-left-rect rect)
(top-right-rect rect)
(bottom-right-rect rect)

(height-rect rect)
(width-rect rect)

(area-rect rect)
(perimeter-rect rect)
                      