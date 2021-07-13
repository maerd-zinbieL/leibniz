#lang sicp

(#%provide make-deque
           empty-deque?
           front-deque
           rear-deque
           front-insert-deque!
           rear-insert-deque!
           front-delete-deque!
           rear-delete-deque!
           display-deque)
;;;double linked list
(define (decell pre value next)
  (list pre value next))
(define (previous d)
  (car d))
(define (value d)
  (cadr d))
(define (next d)
  (caddr d))

(define (set-pre! d p)
  (set-car! d p))
(define (set-value! d v)
  (set-car! (cdr d) v))
(define (set-next! d n)
  (set-cdr! (cdr d) (list n)))

;;;constructor
(define (make-deque)
  (cons '() '()))

;;;help functions
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front! deque item) (set-car! deque item))
(define (set-rear! deque item) (set-cdr! deque item))

;;;predicate
(define (empty-deque? deque)
  (or (null? (front-ptr deque))
      (null? (rear-ptr deque))))

;;;selectors
(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an 
              empty deque" deque)
      (value (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an 
              empty deque" deque)
      (value (rear-ptr deque))))
;;;mutators
(define (front-insert-deque! deque item)
  (let ((new-pair (decell '() item '())))
    (cond ((empty-deque? deque)
           (begin
             (set-front! deque new-pair)
             (set-rear! deque new-pair)
             deque))
          (else
           (begin
             (set-next! new-pair (front-ptr deque))
             (set-pre! (front-ptr deque) new-pair)
             (set-front! deque new-pair)
             deque)))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (decell '() item '())))
    (cond ((empty-deque? deque)
           (begin
             (set-front! deque new-pair)
             (set-rear! deque new-pair)
             deque))
          (else
           (begin
             (set-next! (rear-ptr deque) new-pair)
             (set-pre!  new-pair (rear-ptr deque))
             (set-rear! deque new-pair)
             deque)))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with 
                an empty deque" deque))
        (else
           (begin
             (set-rear! deque (previous (rear-ptr deque)))
             (set-next! (rear-ptr deque) '())
             deque))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with 
                an empty deque" deque))
        (else
           (begin
             (set-front! deque (next (front-ptr deque)))
             (set-pre! (front-ptr deque) '())
             deque))))

(define (display-deque deque)
  (let ((front (front-ptr deque)))
    (define (travel ptr)
      (cond ((not (null? ptr))
             (cons (value ptr)
                   (travel (next ptr))))
            (else '())))
    (travel front)))

;;;test
(define deq (make-deque))
(display-deque(front-insert-deque! deq 'a))
(display-deque(front-insert-deque! deq 'b))
(display-deque(rear-insert-deque! deq 'z))
(display-deque(rear-insert-deque! deq 'y))