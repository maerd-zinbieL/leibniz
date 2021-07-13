(load "stream.scm")
(define integers 
  (cons-stream 1 (add-streams ones integers)))

(define (partial-sums s)
  (define ps
    (cons-stream (stream-car s)
                 (add-streams
                  (stream-cdr s)
                  ps)))
  ps)

(define test (partial-sums integers))
(stream-ref test 10)
test