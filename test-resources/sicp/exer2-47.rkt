#lang sicp

(define (make-frame-list origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame-list frame)
  (car frame))

(define (edge1-frame-list frame)
  (car (cdr frame)))

(define (edge2-frame-list frame)
  (car (cdr (cdr frame))))

(define (make-frame-cons origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame-cons frame)
  (car frame))

(define (edge1-frame-cons frame)
  (car (cdr frame)))

(define (edge2-frame-cons frame)
  (cdr (cdr frame)))