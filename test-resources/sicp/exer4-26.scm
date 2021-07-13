(define-syntax unless-syntax
  (syntax-rules ()
    ((unless-syntax condition usual-value exceptional-value)
     (if condition exceptional-value usual-value))))

(define (factorial n)
  (unless-syntax (= n 1)
          (* n (factorial (- n 1)))
          1))

(define (unless-proc condition usual-value exceptional-value)
  (if condition  exceptional-value usual-value))

(define need-even? '(#t #f #t #f))
(define x '(1 3 5 7))
(define y '(2 4 6 8))
(map unless-proc need-even? x y)
