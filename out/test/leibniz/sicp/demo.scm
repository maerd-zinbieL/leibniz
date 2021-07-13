; https://eli.thegreenplace.net/2008/03/07/sicp-section-53
(load "../5-2/regsim.scm")

(define fib
  (make-machine
    '(n x y a b c val n1 the-cars the-cdrs free)
    `((= ,=) (+ ,+) (printf ,printf)
      (vector-ref ,vector-ref) 
      (vector-set! ,vector-set!) 
      (make-vector ,make-vector))
    '(
      ; create the-cars and the-cdrs vectors
      (assign the-cars (op make-vector) (const 100))
      (assign the-cdrs (op make-vector) (const 100))

      ; init the free pointer
      (assign free (const 0))

      ; n <- (cons x y)
      (perform (op vector-set!) (reg the-cars) (reg free) (reg x))
      (perform (op vector-set!) (reg the-cdrs) (reg free) (reg y))
      (assign n (reg free))
      (assign free (op +) (reg free) (const 1))

      ; print (car x)
      (assign val (op vector-ref) (reg the-cars) (reg n))
      (perform (op printf) (const "~a~%") (reg val))

      ; print (cdr y)
      (assign val (op vector-ref) (reg the-cdrs) (reg n))
      (perform (op printf) (const "~a~%") (reg val))      
    )))

(set-register-contents! fib 'x 100)
(set-register-contents! fib 'y 222)
(start fib)