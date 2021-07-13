(define true
  (lambda (a b)
      a))

(define false
  (lambda (a b)
      b))

(define not
  (lambda (a)
    (a false true)))

(define and
  (lambda (a b)
    (a b false)))

(define or
  (lambda (a b)
    (a true b)))

(define is-zero?
  (lambda (a)
     ((a false) not true)))
  

;;;test 

