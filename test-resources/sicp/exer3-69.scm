(load "stream.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream 
       (stream-car s1)
       (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) 
                  (list (stream-car s) x))
                (stream-cdr t))
    (interleave
     (stream-map (lambda (x) 
                   (list  x (stream-car t)))
                 (stream-cdr s))
     (pairs (stream-cdr s) (stream-cdr t))))))

(define (triples s t u)
  (cons-stream (list
                (stream-car s)
                (stream-car t)
                (stream-car u))
    (interleave
      (stream-map 
        (lambda (x)
          (cons (stream-car s) x))
        (pairs t (stream-cdr u)))
      (triples (stream-cdr s)
               (stream-cdr t)
               (stream-cdr u)))))

; (define (square x) (* x x))

(define triangles (triples integers integers integers))

(define triangles-90
  (stream-filter (lambda (x) 
                   (= (square (caddr x)) 
                      (+ (square (car x))
                         (square (cadr x)))))
                 triangles))

(dsn triangles-90 5)