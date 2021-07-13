(load "stream.scm")

(define (partial-sums s)
  (define ps
    (cons-stream (stream-car s)
                 (add-streams
                  (stream-cdr s)
                  ps)))
  ps)

(define (pi-summands n)
  (cons-stream 
   (/ 1.0 n)
   (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream 
   (partial-sums (pi-summands 1)) 4))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))     ; Sₙ₋₁
        (s1 (stream-ref s 1))     ; Sₙ
        (s2 (stream-ref s 2)))    ; Sₙ₊₁
    (cons-stream 
     (- s2 (/ (square (- s2 s1))
              (+ s0 (* -2 s1) s2)))
     (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream 
   s
   (make-tableau
    transform
    (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

(define (accelerated-sequence-n transform s n)
  (stream-ref (make-tableau transform s) n))

(define pi
 (accelerated-sequence euler-transform
                       pi-stream))

(define pi1
 (accelerated-sequence-n euler-transform
                       pi-stream 1))

(define pi3
 (accelerated-sequence-n euler-transform
                       pi-stream 3))

(define pi5
 (accelerated-sequence-n euler-transform
                       pi-stream 5))

(define pi7
 (accelerated-sequence-n euler-transform
                       pi-stream 7))

(define pi9
 (accelerated-sequence-n euler-transform
                       pi-stream 9))