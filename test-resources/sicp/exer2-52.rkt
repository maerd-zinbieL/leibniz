#lang sicp

(define (alt-corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))
            (corner (alt-corner-split painter (- n 1))))
          (beside (below painter up)
                  (below right corner)))))

(define (square-limit painter n)
  (let ((combine4 
         (square-of-four flip-vert 
                         rotate180
                         identity 
                         flip-horiz)))
    (combine4 (corner-split painter n))))