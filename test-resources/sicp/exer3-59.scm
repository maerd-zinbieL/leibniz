(load "stream.scm")

(define (integrate-series s)
  (mul-streams (stream-map / ones integers) s))

(define cosine-series 
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))