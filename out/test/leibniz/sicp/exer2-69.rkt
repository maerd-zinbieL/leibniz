#lang sicp

(#%require "huffman.rkt")

(define (generate-huffman-tree pairs)
  (successive-merge 
   (make-leaf-set pairs)))

; (define (successive-merge set)
;   (define (iter res set)
;     (if (= (length set) 1)
;         res
;         (let ((small-0 (car set))
;               (small-1 (cadr set)))
;           (let ((node (make-code-tree small-0 small-1)))
;             (iter node (adjoin-set node (cddr set)))))))
;   (iter '() set))
(define (successive-merge set)
  (if (= (length set) 1)
      (car set)
      (let ((small-0 (car set))
            (small-1 (cadr set)))
        (let ((node (make-code-tree small-0 small-1)))
          (successive-merge (adjoin-set node (cddr set)))))))

(define t1 (generate-huffman-tree '((A 4) (C 1) (D 1) (B 2) ) ))
(define t2 (generate-huffman-tree '((A 3) (B 5) (C 6) (D 6)))) 
(define t1_
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree 
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

t1
t1_
(decode '(0 1 1 1 1 0 1 1 0) t1)
(encode '(A B C D) t1) 
  

