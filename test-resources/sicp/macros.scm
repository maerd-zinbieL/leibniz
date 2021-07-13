;;;chez scheme
;;;https://www.youtube.com/watch?v=8KSw-u2o8ew


;[ => (
;] => )

;let  
; (define-syntax my-let
;   (syntax-rules ()
;     [(let ((x e)) body)
;      ((lambda (x) body) e)]))
;syntax-case
; (define-syntax my-let
;   (syntax-rules ()
;     [(_ ((x e)) body)
;      ((lambda (x) body) e)]))

; (define-syntax my-let
;   (syntax-rules ()
;     [(_ ((x e) ... ) body)
;      ((lambda (x ...) body) e ...)]))

(define-syntax my-let
  (syntax-rules ()
    [(_ ((x* e*) ... ) body body* ...)
     ((lambda (x* ... ) body body* ...) e* ...)])) 

(my-let ((x 5))
  (* x x))

(expand '(my-let (( x (+ 2 3)))
           (* x x)))

;;;let*
(define-syntax my-let*
  (syntax-rules ()
    [(let* () body body* ...)
     (let () body body* ...)]))
(let* () (+ 2 3))

(define-syntax my-let*
  (syntax-rules ()
    [(let* () body body* ...)
     (let () body body* ...)]
    [(let* ((x e)(x* e*) ...) body body* ...)
     (let ((x e))
       (let* ((x* e*) ... )
         body body* ...))]))

;;; and
(define-syntax my-and
  (syntax-rules ()
    [(my-and) #t]
    [(my-and e) e]
    [(my-and e e* ...)
     (if e
         (my-and e* ...)
         #f)]))

;;; or
(define-syntax my-or
  (syntax-rules ()
    [(my-or) #f]
    [(my-or e e* ...)
     (if e
         e
         (my-or e* ... ))]))
;上面的e被求值两次
(define-syntax my-or
  (syntax-rules ()
    [(my-or) #f]
    [(my-or e) e] ;要不要这一行？严格来说不要，但是会引起一些问题
    [(my-or e e* ...)
     (let ((t e))
       (if t
           t
           (my-or e* ... )))]))

;;;hygine

(print-gensym 'pretty/suffix)

(expand '(let ([t 5])
           (or #f t)))

(print-gensym $f)
(let ([if (lambda (x y z) #f)])
  (or #f 4))