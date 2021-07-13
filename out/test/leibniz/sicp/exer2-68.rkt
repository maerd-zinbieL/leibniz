#lang sicp

(#%require "huffman.rkt")

(define (encode message tree)
  (if (null? message)
      '()
      (append 
       (encode-symbol (car message) 
                      tree)
       (encode (cdr message) tree))))

(define (encode-symbol char tree)
  (define (in? char chars)
    (cond ((null? chars) false)
          ((equal? char (car chars)) true)
          (else (in? char (cdr chars)))))
  (cond ((leaf? tree) '())
        ((in? char (symbols (left-branch tree)))
         (cons 0 (encode-symbol char (left-branch tree))))
        ((in? char (symbols (right-branch tree)))
         (cons 1 (encode-symbol char (right-branch tree))))
        (else (error "symbol is not in the tree:" char))))

(define sample-tree
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree 
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

(define sample-message 
  '(1 1 1 1 0 0 1 0 1 0 1 1 1 0))

(encode (decode sample-message sample-tree) sample-tree)

(encode '(A B C A F A) sample-tree)