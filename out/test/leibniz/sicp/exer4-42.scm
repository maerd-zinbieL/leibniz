(define (xor p q)
    (if p (not q) q))

;;;使用amb
(define (liars-amb)
  (let ((betty (amb 1 2 3 4 5))
        (ethel (amb 1 2 3 4 5))
        (joan (amb 1 2 3 4 5))
        (kitty (amb 1 2 3 4 5))
        (mary (amb 1 2 3 4 5)))
    (require
     (xor (= kitty 2)
          (= betty 3)))
    (require
     (xor (= ethel 1)
          (= joan 2)))
    (require
     (xor (= joan 3)
          (= ethel 5)))
    (require
     (xor (= kitty 2)
          (= mary 4)))
    (require
     (xor (= mary 4)
          (= betty 1)))
    (require (distinct?
              (list betty ethel joan kitty mary)))
    (list (list 'betty betty)
          (list 'ethel ethel)
          (list 'joan joan)
          (list 'kitty kitty)
          (list 'mary mary))))
;((betty 3) (ethel 5) (joan 2) (kitty 1) (mary 4))


;;;使用普通scheme
;;;help procedures
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(define (permutations s)
  (if (null? s)
      (list '())  
      (flatmap (lambda (x)
                 (map (lambda (p) 
                        (cons x p))
                      (permutations 
                       (remove x s))))
               s)))

(define (liars-ordinary)
  (define (check solution)
    (let ((betty (list-ref solution 0))
          (ethel (list-ref  solution 1))
          (joan (list-ref  solution 2))
          (kitty (list-ref  solution 3))
          (mary (list-ref  solution 4)))
      (and (xor (= kitty 2)
                (= betty 3))
           (xor (= ethel 1)
                (= joan 2))
           (xor (= joan 3)
                (= ethel 5))
           (xor (= kitty 2)
                (= mary 4))
           (xor (= mary 4)
                (= betty 1))
           )))
  (filter check (permutations '(1 2 3 4 5))))

(liars-ordinary)
;;;失败
; (define (liars)
;   (define girls-says
;     '(
;       ((kitty 2) (betty 3))
;       ((ethel 1) (joan 2))
;       ((joan 3) (ethel 5))
;       ((kitty 2) (mary 4))
;     ((mary 4) (betty 1))
;       ))

;   (define (first-say girls-says)
;     (car girls-says))
;   (define (rest-says girls-says)
;     (cdr girls-says))

;   (define (not-conflict? say choice)
;     (let ((name (car say))
;         (degree (cadr say)))
;       (cond ((null? choice)
;            true)
;             ((member say choice)
;              true)
;             ((equal? name (caar choice))
;              false)
;             ((= degree (cadar choice))
;              false)
;             (else (not-conflict? say (cdr choice))))))
;   (define (show-res choice)
;     (newline)
;     (display choice)
;     (newline))
;   (define (join say choice)
;     (if (member say choice)
;         choice
;         (cons say choice)))
; (define (choose choice gs)
;   (if (null? gs)
;       (show-res choice)
;       (let ((say1 (car (first-say gs)))
;             (say2 (cadr (first-say gs))))
;         (if (not-conflict? say1 choice)
;             (begin
;               (choose (join say1 choice)
;                       (rest-says gs))
;               (if (not-conflict? say2 choice)
;                   (choose (join say2 choice)
;                           (rest-says gs))))))))
; (choose '() girls-says))