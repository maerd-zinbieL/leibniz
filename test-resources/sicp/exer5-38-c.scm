(load "compiler-test.scm")
(define test-code
  '(define (factorial n)
     (if (= n 1)
         1
         (* (factorial (- n 1)) n))))


; (load "exer5-38-a&b.scm")
(length (test-compiler test-code 'val 'next))
; without open code: 79
; with open code: 40