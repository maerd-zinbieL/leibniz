(define (row-queen queen)
  (car queen))

(define (col-queen queen)
  (cdr queen))

(define (make-queen)
  (cons (amb 1 2 3 4 5 6 7 8) (amb 1 2 3 4 5 6 7 8)))

(define (row-save? queens)
  (distinct? (map row-queen queens)))

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
  (and (row-save? queens)
       (column-save? queens)
       (diagonal-save? queens)))

;;;too slow
; (define (eight-queens)
;   (let ((a (make-queen))
;         (b (make-queen))
;         (c (make-queen))
;         (d (make-queen))
;         (e (make-queen))
;         (f (make-queen))
;         (g (make-queen))
;         (h (make-queen)))
    
;     (require (save? (list a b c d e f g h)))
;     (list a b c d e f g h)))

; too slow
(define (eight-queens)
  (let ((a (make-queen))
        (b (make-queen)))
    (require (save? (list a b)))
    (let ((c (make-queen)))
      (require (save? (list a b c)))
      (let ((d (make-queen)))
        (require (save? (list a b c d)))
        (let ((e (make-queen)))
          (require (save? (list a b c d e)))
          (display (list a b c d e))
          (newline)
          (let ((f (make-queen)))
            (require (save? (list a b c d e f)))
            (let ((g (make-queen)))
              (require (save? (list a b c d e f g)))
              (let ((h (make-queen)))
                (require (save? (list a b c d e f g h)))
                (list a b c d e f g h)))))))))

(eight-queens)