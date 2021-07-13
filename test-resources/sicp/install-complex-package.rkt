#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%provide  make-complex-from-real-imag
            make-complex-from-mag-ang
            my-angle
            my-magnitude
            my-imag-part
            my-real-part)

(define (my-real-part z) (apply-generic 'my-real-part z)) 
(define (my-imag-part z) (apply-generic 'my-imag-part z)) 
(define (my-magnitude z) (apply-generic 'my-magnitude z)) 
(define (my-angle z) (apply-generic 'my-angle z))
(define (square x) (* x x))

(define (install-rectangular-package)
  ;; internal procedures
  (define (my-real-part z) (car z))
  (define (my-imag-part z) (cdr z))
  (define (make-from-real-imag x y) 
    (cons x y))
  (define (my-magnitude z)
    (sqrt (+ (square (my-real-part z))
             (square (my-imag-part z)))))
  (define (my-angle z)
    (atan (my-imag-part z) (my-real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) 
    (attach-tag 'rectangular x))
  (put 'my-real-part '(rectangular) my-real-part)
  (put 'my-imag-part '(rectangular) my-imag-part)
  (put 'my-magnitude '(rectangular) my-magnitude)
  (put 'my-angle '(rectangular) my-angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) 
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) 
         (tag (make-from-mag-ang r a))))
  'done)

;;;极坐标
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-polar-package)
  ;; internal procedures
  (define (my-magnitude z) (car z))
  (define (my-angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (my-real-part z)
    (* (my-magnitude z) (cos (my-angle z))))
  (define (my-imag-part z)
    (* (my-magnitude z) (sin (my-angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'my-real-part '(polar) my-real-part)
  (put 'my-imag-part '(polar) my-imag-part)
  (put 'my-magnitude '(polar) my-magnitude)
  (put 'my-angle '(polar) my-angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) 
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) 
         (tag (make-from-mag-ang r a))))
  'done)

(install-polar-package)
(install-rectangular-package)

;;;generic interface
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-complex-package)
  ;; imported procedures from rectangular 
  ;; and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 
          'rectangular) 
     x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) 
     r a))
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag 
     (+ (my-real-part z1) (my-real-part z2))
     (+ (my-imag-part z1) (my-imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag 
     (- (my-real-part z1) (my-real-part z2))
     (- (my-imag-part z1) (my-imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang 
     (* (my-magnitude z1) (my-magnitude z2))
     (+ (my-angle z1) (my-angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang 
     (/ (my-magnitude z1) (my-magnitude z2))
     (- (my-angle z1) (my-angle z2))))
  (define (addd-complex z1 z2 z3)
    (make-from-real-imag (+ (my-real-part z1)
                            (my-real-part z2)
                            (my-real-part z3))
                         (+ (my-imag-part z1)
                            (my-imag-part z2)
                            (my-imag-part z3))))
  ;; interface to rest of the system
  (put 'addd '(complex complex complex)
       (lambda (z1 z2 z3) (tag (addd-complex z1 z2 z3))))
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) 
         (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) 
         (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) 
         (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) 
         (tag (div-complex z1 z2))))
  (put 'negative '(complex)
       (lambda (z)
         (tag (make-from-real-imag
               (- (my-real-part z))
               (- (my-imag-part z))))))
  (put 'equ? '(complex complex)
       (lambda (x y)
         (and (= (my-real-part x)
                 (my-real-part y))
              (= (my-imag-part x)
                 (my-imag-part y)))))
  (put '=zero? '(complex)
       (lambda (x)
         (= (my-magnitude x) 0)))
  (put 'make-from-real-imag 'complex
       (lambda (x y) 
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) 
         (tag (make-from-mag-ang r a))))
 
  ;;;书上没有提供这些选择函数的接口，因为封装的需要
  (put 'my-real-part '(complex) my-real-part)
  (put 'my-imag-part '(complex) my-imag-part)
  (put 'my-magnitude '(complex) my-magnitude)
  (put 'my-angle '(complex) my-angle)
  'done)

(install-complex-package)
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))