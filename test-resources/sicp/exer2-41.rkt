#lang sicp

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op 
                        initial 
                        (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low 
            (enumerate-interval 
             (+ low 1) 
             high))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define (unique-triples n s)
  (filter (lambda (triple)
            (< (car (cdr triple)) ;second element
               (car (cdr (cdr triple))))) ;last element
          (flatmap (lambda (i)
                     (map (lambda (j) (list i j (- s i j)))
                          (enumerate-interval (+ 1 i) n)))
                   (enumerate-interval 1 n))))

 (define (check n s) ;; a solution on the Internet
   (filter (lambda (list) (= (accumulate + 0 list) s)) 
          (flatmap 
           (lambda (i) 
             (flatmap (lambda (j) 
                  (map (lambda (k) (list i j k)) 
                       (enumerate-interval 1 (- j 1)))) 
                  (enumerate-interval 1 (- i 1)))) 
             (enumerate-interval 1 n))))

(unique-triples 5 7)
(check 5 7)
(unique-triples 100 10)
(check 100 10)