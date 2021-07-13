#lang sicp

(#%require "huffman.rkt")

; (define pairs '((A 2) (NA 16) (BOOM 1) (SHA 3)
;                 (GET 2) (YIP 9) (JOB 2) (WAH 1)))
(define pairs '((a 2) (na 16) (boom 1) (Sha 3)
                (Get 2) (yip 9) (job 2) (Wah 1)))
(define tree (generate-huffman-tree pairs))

(define msg
  '(Get a job
        Sha na na na na na na na na
        Get a job
        Sha na na na na na na na na
        Wah yip yip yip yip 
        yip yip yip yip yip
        Sha boom))
(length msg)
(define encoded (encode msg tree))
(length encoded)