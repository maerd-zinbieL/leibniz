#lang sicp

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op 
                        initial 
                        (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low 
            (enumerate-interval 
             (+ low 1) 
             high))))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define empty-board '(()))

(define (make-position row col)
  (cons row col))

(define row-position car)

(define col-position cdr)

(define (adjoin-position new-row k rest-of-queens)
  (if (= 1 k)
      (list (make-position new-row k))
      (cons (make-position new-row k)
            rest-of-queens)))

(define (safe? k positions)
  (define (check new-queen rest-queens)
    (cond ((null? rest-queens) true)
          ((= (row-position (car rest-queens))
              (row-position new-queen))
           false)
          ((= (col-position (car rest-queens))
              (col-position new-queen))
           false)
          ((= (+ (col-position (car rest-queens))
                 (row-position (car rest-queens)))
              (+ (col-position new-queen)
                 (row-position new-queen)))
           false)
          ((= (- (col-position (car rest-queens))
                 (row-position (car rest-queens)))
              (- (col-position new-queen)
                 (row-position new-queen)))
           false)
          (else (check new-queen (cdr rest-queens)))))
  (let ((new-queen
         (car (filter (lambda (position)
                        (= (col-position position) k))
                      positions)))
        (rest-queens (filter (lambda (position)
                              (not(= (col-position position) k)))
                            positions)))
     (check new-queen rest-queens)))


(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) 
           (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position 
                    new-row 
                    k 
                    rest-of-queens))
                 (enumerate-interval 
                  1 
                  board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; (define (check-my-solution n)
;   (let ((solutions-count
;          '(1 0 0 2 10 4 40 92 352 724 2680 14200)))
;     (if (= n 1)
;       true
;       (begin
;         (newline)
;         (display "checking, n = ")
;         (display n)
;         (and (= (length (queens n))
;                 (list-ref solutions-count (- n 1)))
;              (check-my-solution (- n 1)))))))

(newline)
(define start-time (runtime))
(queens 8)
(-(runtime) start-time)
