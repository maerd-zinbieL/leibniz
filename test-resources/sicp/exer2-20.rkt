#lang sicp

(define (reverse items)
  (define (iter items res)
    (if (null? items)
        res
        (iter (cdr items) (cons (car items) res))))
  (iter items (list )))

(define (same-parity x . l)
  (define (iter res l)
    (cond ((null? l) res)
          ((= (remainder (- (car l) x) 2) 0)
           (iter (cons (car l) res ) (cdr l)))
          (else (iter res (cdr l)))))
  (reverse (iter (list x) l)))

(same-parity  2 3 4 5 6 7)