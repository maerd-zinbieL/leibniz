#lang sicp

;;;复数运算
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (add-complex z1 z2)
  (make-from-real-imag 
   (+ (real-part z1) (real-part z2))
   (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag 
   (- (real-part z1) (real-part z2))
   (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang 
   (* (magnitude z1) (magnitude z2))
   (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang 
   (/ (magnitude z1) (magnitude z2))
   (- (angle z1) (angle z2))))

;;;直角坐标
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-from-real-imag real imag)
  (cons real imag))

(define (real-part z)
  (car z))

(define (imag-part z)
  (cdr z))

(define (magnitude z)
  (sqrt (+ (expt (real-part z) 2)
           (expt (imag-part z) 2))))

(define (angle z)
  (atan (imag-part z) (real-part z)))

(define (make-from-mag-ang r a)
  (cons (* r (cos a)) (* r (sin a))))
  

(define z1 (make-from-real-imag 3 4))
(define z2 (make-from-mag-ang (* 2 (sqrt 2)) (/ 3.14159265358979 4) ))

(real-part z2)
(magnitude z1)
(* (angle z2) 4)

(add-complex z1 z2)


;;;极坐标
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-from-mag-ang mag ang)
  (cons mag ang))

(define (magnitude z)
  (car z))

(define (angle z)
  (cdr z))

(define (real-part z)
  (* (magnitude z)
     (cos (angle z))))

(define (imag-part z)
  (* (magnitude z)
     (sin (angle z))))

(define (make-from-real-imag real imga)
  (cons (sqrt (+ (expt real 2)
                 (expt imag 2)))
        (atan imag real)))