#lang sicp

(define (make-monitored f)
  (let ((call-count 0))
    (define (mf argc)
      (cond ((eq? 'how-many-calls? argc)
             call-count)
            ((eq? 'reset-count argc)
             (set! call-count 0))
            (else (begin (set! call-count (+ call-count 1))
                    (f argc)))))
    mf))

(define s (make-monitored sqrt))

(s 100)
(s 'how-many-calls?)
(s 1000)
(s 'how-many-calls?)
(s 'reset-count)
(s 'how-many-calls?)
(s 1000)
(s 'how-many-calls?)