#lang sicp

(define (has-ring? x)
  (let ((visited '()))
    (define (travel x)
      (cond ((null? x)
             false)
            ((not (pair? x))
             false)
            ((memq (cdr x) visited)
             true)
            (else
              (begin
                (set! visited (cons x visited))
                (or (travel (car x))
                    (travel (cdr x)))))))
    (travel x)))

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define z-none (list 'a 'b 'c))
(set-cdr! (last-pair z-none) (cdr z-none))

(has-ring? z-none)
