(load "pairs.scm")

(define int-pairs  (pairs integers integers))

; (define (gaps stream)
;   (let ((count 0))
;     (define (counter stream)
;       (let ((pair (stream-car stream)))
;         (if (= (car pair)
;                (cadr pair))
;             (begin
;               (display count)
;               (display " ")
;               (set! count 0)
;               (counter (stream-cdr stream)))
;             (begin
;               (set! count (+ count 1))
;               (counter (stream-cdr stream))))))
;     (counter stream)))

; f(i,j) = 2^i - 2, i = j
; f(i,j) = 2^i * (j-i) + 2^(i-1) - 2, i < j
(define (locate i j)
  (if (= i j)
      (- (expt 2 i) 2)
      (+ (* (expt 2 i)
            (- j i))
         (expt 2 (- i 1))
         -2)))

(define (check)
  (stream-for-each
   (lambda (pair)
     (display-line
      (equal? pair 
              (stream-ref
                int-pairs
                (locate (car pair) (cadr pair))))))
   int-pairs))

(check)
