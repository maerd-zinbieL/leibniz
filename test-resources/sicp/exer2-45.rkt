#lang sicp

(define (split first second)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split first second) painter (- n 1))))
          (first painter (second smaller smaller))))))
