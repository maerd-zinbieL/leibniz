#lang sicp
(define (pascal-recursive row col)
    (cond ((> col row) (error "unvalid value"))
          ((or (= col 0) (= col row) ) 1)
          (else  (+ (pascal-recursive (- row 1 ) (- col 1) ) 
                    (pascal-recursive (- row 1) col))  )
    )
)
(define (pascal-factorial row col)
    (define (factorial n)
        (define (fact-iter product counter max-count)
            (if (> counter max-count) product
                (fact-iter (* counter product)
                           (+ counter 1)
                           max-count)))
        (fact-iter 1 1 n)
    )

    (/ (factorial row)
       (* (factorial col)
          (factorial (- row col)))
    )
)

; (pascal-recursive 32 16)
(pascal-factorial 1024 256)

