(load "stream.scm")
(define integers 
  (cons-stream 1 (add-streams ones integers)))
(define factorials
  (cons-stream 1 (mul-streams
                  (stream-cdr integers)
                  factorials)))