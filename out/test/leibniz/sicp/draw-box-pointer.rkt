#lang racket

(require pict)
(require sdraw)

(#%provide draw-box-pointer
           draw-box-pointer-table)
(define (save-pict the-pict name kind)
  (define bm (pict->bitmap the-pict))
  (send bm save-file name kind))

(define (draw-box-pointer pairs)
  (if (pair? pairs)
      (save-pict
       (sdraw pairs
              #:arrow-color "Red"
              #:null-style '/)
       "box-pointer.png"
       'png)
      (error "Not pairs")))

(define (draw-box-pointer-table table)
  (sdraw table
         #:arrow-color "Red"
         #:null-style '/))
