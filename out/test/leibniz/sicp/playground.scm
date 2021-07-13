 (define (insert x seq)
    (cond ((null? seq)
           (list x))
          ((equal? x (car seq))
              seq)
        ;   ((member x seq)
        ;    seq)
        ;   ((eq? (car x) (caar seq))
        ;    (cons x seq))
          (else (cons (car seq)
                      (insert x (cdr seq))))))

(define (remove-duplicates seq)
  (if (null? seq)
            '()
            (let ((res (remove-duplicates (cdr seq)))
                  (x (car seq)))
              (insert x res))))

(define seq
  '((a 98)
    (a 78)
    (a 98)
   
  ))
(remove-duplicates seq)

(define (test)
  (for-each write (remove-duplicates seq)))