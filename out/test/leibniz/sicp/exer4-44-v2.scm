; 8!=40320
; 8^8=16777216
(define (row-queen queen)
  (car queen))

(define (col-queen queen)
  (cdr queen))

(define (amb-except xs ls)
  (cond ((null? ls)
         (amb))
        ((member (car ls) xs)
         (amb-except xs (cdr ls)))
        (else (amb (car ls)
                   (amb-except xs (cdr ls))))))
(define (range n)
  (if (= n 0)
      '()
      (cons n (range (- n 1)))))
(define (make-queen row col-except)
  (cons row (amb-except col-except (range 8))))

(define (diagonal-save? queens)
  (and (distinct?
        (map (lambda (queen) (- (row-queen queen)
                           (col-queen queen)))
             queens))
       (distinct?
        (map (lambda (queen) (+ (col-queen queen)
                                (row-queen queen)))
             queens))))

(define (save? queens)
       (diagonal-save? queens))


(define all-possible '())
(define (add possible)
  (permanent-set! all-possible
                  (append all-possible
                          (list possible)))
  (amb))

(define (except-cols queens)
  (if (null? queens)
      '()
      (cons (col-queen (car queens))
            (except-cols (cdr queens)))))

(define (eight-queens)
  (let ((a (make-queen 1 '())))
    (let ((b (make-queen 2 (except-cols (list a)))))
      (require (save? (list a b)))
      (let ((c (make-queen 3 (except-cols (list a b)))))
        (require (save? (list a b c)))
        (let ((d (make-queen 4 (except-cols (list a b c)))))
          (require (save? (list a b c d)))
          (let ((e (make-queen 5 (except-cols (list a b c d)))))
            (require (save? (list a b c d e)))
            ; (display (list a b c d e))
            ; (newline)
            (let ((f (make-queen 6 (except-cols (list a b c d e)))))
              (require (save? (list a b c d e f)))
              (let ((g (make-queen 7 (except-cols (list a b c d e f)))))
                (require (save? (list a b c d e f g)))
                (let ((h (make-queen 8 (except-cols (list a b c d e f g)))))
                  (require (save? (list a b c d e f g h)))

                   (newline)
                   (display (list a b c d e f g h))
                   (add (list a b c d e f g h))
                
                  (list a b c d e f g h))))))))))

(define start-time (runtime))
(time-it eight-queens)
(- (runtime) start-time)
;74.84, 76.82
;用scheme amb跑书上练习2.42的代码，耗时171.65。