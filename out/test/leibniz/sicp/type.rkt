#lang racket

(provide attach-tag type-tag contents)
;;;标志
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (define (attach-tag type-tag contents)
;   (cons type-tag contents))

; (define (type-tag datum)
;   (if (pair? datum)
;       (car datum)
;       (error "Bad tagged datum: 
;               TYPE-TAG" datum)))

; (define (contents datum)
;   (if (pair? datum)
;       (cdr datum)
;       (error "Bad tagged datum: 
;               CONTENTS" datum)))
(define (attach-tag typed-tag contents)
  (cond ((real? contents)
         contents)
        (else (cons typed-tag contents))))

(define (type-tag datum)
  (cond ((exact-integer? datum)
         'scheme-number)
        ((real? datum)
         'real)
        ((pair? datum)
         (car datum))
        (else (error "Bad tagged datum: 
                     TYPE-TAG" datum))))

(define (contents datum)
  (cond ((real? datum)
         datum)
        ((pair? datum)
         (cdr datum))
        (else (error "Bad tagged datum: 
                     CONTENTS" datum))))
