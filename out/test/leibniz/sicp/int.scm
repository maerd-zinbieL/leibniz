(define identity
  (lambda (x)
    x))

(define zero
  (lambda (f)
    identity))

(define inc
  (lambda (n)
    (lambda (f)
      (lambda (x) (f ((n f) x))))))

(define add
  (lambda (a b)
      (lambda (f) (lambda (x) ((b f)((a f) x))))))

(define mul
  (lambda (x y)
      (lambda (z)
        (x (y z)))))

;;; test
(define one (inc zero))
(define two (inc one))
(define three (inc two))

(define (chruch-num->int chruch-num)
  ((chruch-num (lambda (x) (+ x 1))) 0))

(define (int->chruch-num n)
  (if (= 0 n)
      zero
      (add-1 (int->chruch-num (- n 1)))))
