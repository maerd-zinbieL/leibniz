(load "stream.scm")

(define (sign-change-detector current last)
  (cond ((and (>= last 0) (< current 0))
         -1)
        ((and (< last 0) (>= current 0))
         +1)
        (else 0)))

(define zero-crossings
  (stream-map sign-change-detector 
              sense-data 
              (cons-stream 0 sense-data)))