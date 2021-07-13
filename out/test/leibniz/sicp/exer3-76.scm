(define (smooth stream)
  (cons-stream (average
                (stream-car stream)
                (stream-car (stream-cdr stream)))
               (smooth (stream-cdr stream))))

(define (sign-change-detector current last)
  (cond ((and (>= last 0) (< current 0))
         -1)
        ((and (< last 0) (>= current 0))
         +1)
        (else 0)))

(define (make-zero-crossings
         input-stream last-value)
  (cons-stream
   (sign-change-detector 
    (stream-car input-stream) 
    last-value)
   (make-zero-crossings 
    (stream-cdr input-stream)
    (stream-car input-stream))))

(define zero-crossings 
  (make-zero-crossings (smooth sense-data) 0))