; (save? p a)
; => true, if (p a) return a value
; => false, if (p a) is a infinite loop
(define inf
  (lambda ()
    ((lambda (x) (x x))
     (lambda (x) (x x)))))

(define diag1
  (lambda (p)
    (if (save? p p)
        (inf)
        42)))

(diag1 diag1) ;=> return a value or infinite loop

(define diag2
  (lambda (p)
    (if (save? p p)
        (other-then (p p))
        false)))

(define other-then
  (lambda (x)
    (if (eq? x 'A)
        'A
        x)))

(diag2 diag2)
;if (save? diag2 diag2)
;(diag2 diag2) => (othen-than (diag2 diag2))