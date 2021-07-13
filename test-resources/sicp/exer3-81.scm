(load "stream.scm")

(define (rand-update x) 
  (let ((a 27) (b 26) (m 127)) 
    (modulo (+ (* a x) b) m))) 

(define random-init 37)

(define (rand commands)
  (define (proc x m)
    (cond ((eq? m 'generate)
           (rand-update x))
          ((number? m)
           m)
          (else (error "Unkown operation:
                       RAND" m))))
  (cons-stream random-init
   (stream-map proc (rand commands) commands)))
  
  
  