(load "integral.scm")

(define (RC r c dt)
    (lambda (i v0)
      (add-streams
        (integral
         (scale-stream i (/ 1 c)) v0 dt)
        (scale-stream i r))))

(define RC1 (RC 5 1 0.5))

(define v (RC1 integers 1))

(dsn v 10)
                   