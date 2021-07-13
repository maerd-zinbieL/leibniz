#lang sicp

(define tl (make-vect 0 1))

(define tr (make-vect 1 1))

(define bl (make-vect 0 0))

(define br (make-vect 1 0))

(define l (make-vect 0 0.5))
(define t (make-vect 0.5 1))
(define r (make-vect l 0.5))
(define b (make-vect 0.5 0))


(define outline
  (segments->painter (list
                      (make-segment bl tl)
                      (make-segment tl tr)
                      (make-segment tr br)
                      (make-segment br bl))))

(define X
  (segments->painter (list
                      (make-segment bl tr)
                      (make-segment tl br))))

(define diamond
  (segments->painter (list
                      (make-segment l t)
                      (make-segment t r)
                      (make-segment r b)
                      (make-segment b l))))

(define wave
  (segments->painter wave-segment-list))