(load "stream.scm")

(define (partial-sums s)
  (define ps
    (cons-stream (stream-car s)
                 (add-streams
                  (stream-cdr s)
                  ps)))
  ps)

(define (ln-summands n)
  (cons-stream 
   (/ 1 n)
   (stream-map - (ln-summands (+ n 1)))))

(ln-summands 1)

(define t1
  (cons-stream
   (/ 1 1)
   (stream-map - (ln-summands 2))))

(define t2
  (cons-stream
   (/ 1 1)
   (stream-map - (cons-stream (/ 1 2 )
                  (stream-map - (ln-summands 3))))))

(define t3
  (cons-stream
   (/ 1 1)
   (stream-map - (cons-stream (/ 1 2 )
                   (stream-map - (cons-stream (/ 1 3)
                                  (stream-map - (ln-summands 4))))))))

;(define ln-2 (partial-sums (ln-summands 1)))

;(dsn ln-2 100)