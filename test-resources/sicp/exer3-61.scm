(load "stream.scm")

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1)
                  (stream-car s2))
               (add-streams
                (scale-stream (stream-cdr s2)
                              (stream-car s1))
                (mul-series (stream-cdr s1) s2))))

(define (1/s s)
  (define x
    (cons-stream 1
                 (mul-series (scale-stream (stream-cdr s) -1)
                             x)))
  x)

;;;test
(define (integrate-series s)
  (mul-streams (stream-map / ones integers) s))

(define exp-series
  (cons-stream 
   1 (integrate-series exp-series)))

(define cosine-series 
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define t1 (mul-series (1/s exp-series)
                       exp-series))
(define t2 (mul-series (1/s cosine-series)
                       cosine-series))
(stream-ref t1 10)
(stream-ref t2 10)

                           