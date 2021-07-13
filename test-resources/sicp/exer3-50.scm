(load "stream.scm")
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc 
                    (map stream-cdr
                         argstreams))))))
; (display-stream
;  (stream-map +
;              (stream-enumerate-interval 1 10)
;              (stream-enumerate-interval 1 10)))
            
(stream-cdr (stream-enumerate-interval 1 10))