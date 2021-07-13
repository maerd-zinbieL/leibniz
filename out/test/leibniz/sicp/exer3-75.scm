(define (make-zero-crossings 
         input-stream last-value-avpt last-value-origin)
  (let ((avpt 
         (/ (+ (stream-car input-stream) 
               last-value-origin) 
            2)))
    (cons-stream 
     (sign-change-detector avpt last-value)
     (make-zero-crossings 
      (stream-cdr input-stream) avpt (stream-car input-stream) ))))