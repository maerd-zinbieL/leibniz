(load "stream.scm")

(define (square x) (* x x))

(define (random-in-range low high) 
  (let ((range (- high low))) 
    (+ low (random range))))

(define (in-circle? x1 x2 y1 y2)
  (let ((x0 (/ (+ x1 x2) 2))
        (y0 (/ (+ y1 y2) 2))
        (d (min (- x2 x1)
                (- y2 y1))))
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (<= (+ (square (- x x0))
             (square (- y y0)))
          (square (/ d 2))))))

(define (monte-carlo experiment-stream 
                     passed 
                     failed)
  (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
      (stream-cdr experiment-stream) 
      passed 
      failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define (estimate-integral P x1 x2 y1 y2)
  (define (experiment-stream)
    (cons-stream
     (P x1 x2 y1 y2)
     (experiment-stream)))
  (monte-carlo (experiment-stream) 0 0))

(define pi-stream
  (stream-map
   (lambda(p) (* p 4.0))
   (estimate-integral in-circle? -1.0 1.0 -1.0 1.0 )))
  