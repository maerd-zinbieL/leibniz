(load "stream.scm")

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1)
                  (stream-car s2))
               (add-streams
                (scale-stream (stream-cdr s2)
                              (stream-car s1))
                (mul-series (stream-cdr s1) s2))))

;;;test
(define (integrate-series s)
  (mul-streams (stream-map / ones integers) s))

(define exp-series
  (cons-stream 
   1 (integrate-series exp-series)))

(define cosine-series 
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(define test
  (add-streams
   (mul-series cosine-series cosine-series)
   (mul-series sine-series sine-series)))