#lang sicp

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))
    (define (front-queue queue)
      (if (empty-queue?)
          (error "FRONT called with an 
                 empty queue" queue)
          (car front-ptr)))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (if (empty-queue?)
            (begin
              (set! front-ptr new-pair)
              (set! rear-ptr new-pair)
              front-ptr)
            (begin
              (set-cdr! rear-ptr new-pair)
              (set! rear-ptr new-pair)
              front-ptr))))
    (define (delete-queue!)
      (if (empty-queue?)
          (error "FRONT called with an 
                 empty queue" front-ptr)
          (begin
            (set! front-ptr (cdr front-ptr))
            front-ptr)))
    (define (display-queue)
      front-ptr)
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            ((eq? m 'display-queue) display-queue)
            (else (error "Undefined 
                         operation: MAKE-QUEUE" m))))
    dispatch))


(define (empty-queue? q) (q 'empty-queue?))
(define (front-queue q) (q 'front-queue))
(define (insert-queue! q item) ((q 'insert-queue!) item))
(define (delete-queue! q) ((q 'delete-queue!)))

(define q1 (make-queue))

(insert-queue! q1 'a)
; ((a) a)

(insert-queue! q1 'b)
; ((a b) b)

(delete-queue! q1)
; ((b) b)

(delete-queue! q1)
; (() b)