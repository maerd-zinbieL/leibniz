(load "stream.scm")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< (weight s1car)
                     (weight s2car))
                  (cons-stream 
                   s1car 
                   (merge-weighted
                      (stream-cdr s1) 
                      s2
                      weight)))
                 ((> (weight s1car)
                     (weight s2car))
                  (cons-stream 
                   s2car 
                   (merge-weighted
                      s1 
                      (stream-cdr s2)
                      weight)))
                 (else
                  (cons-stream 
                   s1car
                   (merge-weighted
                    (stream-cdr s1)
                    s2
                    weight))))))))

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted 
      (stream-map (lambda (x) 
                    (list (stream-car s) x))
        (stream-cdr t))
      (weighted-pairs
       (stream-cdr s)
       (stream-cdr t)
        weight)
      weight)))

(define ramanujan-numbers
  ((lambda ()
    (define (weight pair)
      (let ((i (car pair))
            (j (cadr pair)))
        (+ (* i i i)
           (* j j j))))
    (define (filter stream)
      (let ((first (stream-car stream))
            (second (stream-car (stream-cdr stream)))
            (third (stream-car (stream-cdr (stream-cdr stream)))))
        (if
          (=(weight first)
               (weight second))
            
            ; (and (= (weight first)
            ;         (weight second))
            ;      (not (= (weight second)
            ;              (weight third))))
            (cons-stream (weight first)
             (filter (stream-cdr (stream-cdr stream))))
            (filter (stream-cdr stream)))))
    (filter (weighted-pairs integers integers weight)))))

(dsn ramanujan-numbers 100)
  