#lang sicp
(define (deep-reverse items)
  (define (iter items res)
    (if (null? items)
        res
        (let ((item (car items))
              (residue (cdr items)))
          (if (pair? (car items))
              (iter residue (cons (deep-reverse item) res))
              (iter residue (cons item res))))))
  
  (iter items (list )))

(define x (list (list 1 2) (list 3 (list 4 5)))) 

(deep-reverse x)
