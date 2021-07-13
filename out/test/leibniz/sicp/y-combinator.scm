;;;loop:
;;;((lambda (x) (x x))
;;;  (lambda (x) (x x)))
;;;(define (loop) (loop))
;;;上述都是infinite loop，有什么联系吗？

(define Y
  (lambda (f)
    ((lambda (x) (f (x x)))
     (lambda (x) (f (x x))))))

; 上面的Y会造成死循环。
(define F
  (lambda (g)
    (lambda (n)
      (if (= n 0)
        1
        (* n (g (- n 1)))))))

(Y F)

((lambda (x) (F (x x)))
 (lambda (x) (F (x x))))

(F
 ((lambda (x) (F (x x)))
  (lambda (x) (F (x x)))))

(F (Y F))

;;;下面的不会。
(define Z
  (lambda (f)
    ((lambda (x) (x x))
     (lambda (x) (f (lambda (y) ((x x) y)))))))

(define factorial (Z F))
(factorial 5)