(define (row-queen queen)
  (car queen))

(define (col-queen queen)
  (cdr queen))

(define (make-queen row)
  (cons row (amb 1 2 3 4 5 6 7 8)))

(define (column-save? queens)
  (distinct? (map col-queen queens)))

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
  (and (column-save? queens)
       (diagonal-save? queens)))

;;;still slow
; (define (eight-queens)
;   (let ((a (make-queen 1))
;         (b (make-queen 2))
;         (c (make-queen 3))
;         (d (make-queen 4))
;         (e (make-queen 5))
;         (f (make-queen 6))
;         (g (make-queen 7))
;         (h (make-queen 8)))
    
;     (require (save? (list a b c d e f g h)))
;     (list a b c d e f g h)))

(define all-possible '())
(define (add possible)
  (permanent-set! all-possible
                  (append all-possible
                          (list possible)))
  (amb))

(define (eight-queens)
  (let ((a (make-queen 1))
        (b (make-queen 2)))
    (require (save? (list a b)))
    (let ((c (make-queen 3)))
      (require (save? (list a b c)))
      (let ((d (make-queen 4)))
        (require (save? (list a b c d)))
        (let ((e (make-queen 5)))
          (require (save? (list a b c d e)))
          ; (display (list a b c d e))
          ; (newline)
          (let ((f (make-queen 6)))
            (require (save? (list a b c d e f)))
            (let ((g (make-queen 7)))
              (require (save? (list a b c d e f g)))
              (let ((h (make-queen 8)))
                (require (save? (list a b c d e f g h)))

                (newline)
                (display (list a b c d e f g h))
                (add (list a b c d e f g h))
                
                (list a b c d e f g h)))))))))

(define start-time (runtime))
(eight-queens)
(- (runtime) start-time)
;146.44