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

(define empty-board '(()))

(define (make-position row col)
  (list row col))

(define row-position car)

(define (col-position position)
  (car (cdr position)))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) 
            (append (cdr list1) 
                    list2))))

(define (adjoin-position new-row k rest-of-queens)
  (if (= 1 k)
      (list (list new-row k))
      (append rest-of-queens
              (list (make-position new-row k)))))

(define (safe? k positions)
  (define (check new-queen to-checks)
    (cond ((null? to-checks) true)
          ((= (row-position (car to-checks))
              (row-position new-queen))
           false)
          ((= (col-position (car to-checks))
              (col-position new-queen))
           false)
          ((= (+ (col-position (car to-checks))
                 (row-position (car to-checks)))
              (+ (col-position new-queen)
                 (row-position new-queen)))
           false)
          ((= (- (col-position (car to-checks))
                 (row-position (car to-checks)))
              (- (col-position new-queen)
                 (row-position new-queen)))
           false)
          (else (check new-queen (cdr to-checks)))))
  (let ((new-queen
         (car (filter (lambda (position)
                   (= (col-position position) k))
                   positions)))
        (to-checks (filter (lambda (position)
                        (not(= (col-position position) k)))
                           positions)))
    (check new-queen to-checks)))

(define queens-cols-count 0)
(define (queens board-size)
  (define (queen-cols k)
    (set! queens-cols-count (+ queens-cols-count  1))
    (if (= k 0)
        (list empty-board)
        (filter
          (lambda (positions) 
            (safe? k positions))
          (flatmap
            (lambda (new-row)
              (map (lambda (rest-of-queens)
                      (adjoin-position 
                       new-row k rest-of-queens))
                   (queen-cols (- k 1))))
            (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

(queens 6)
(display queens-cols-count)