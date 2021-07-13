#lang sicp

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op 
                      initial 
                      (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) 
            (append (cdr list1) 
                    list2))))

(define (reverse0 sequence)
  (fold-right 
   (lambda (x y) (append y (list x))) nil sequence))

; (reverse0 '(1 2))
; (op 1 (fold-right op nil  '(2)))
; (op 1 (op 2 nil))

(define (reverse1 sequence)
  (fold-left 
   (lambda (x y) (cons y x)) nil sequence))

(define a (list 1 2 3 34))
(reverse0 a)
(reverse1 a)