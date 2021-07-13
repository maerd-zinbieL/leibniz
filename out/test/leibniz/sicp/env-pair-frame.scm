(load "utils.scm")


;;;环境的表示
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())


;;;frame 的表示
;represent a frame as a pair of lists
(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))


;;;环境的操作
;represent a frame as a pair of lists
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" 
                 vars 
                 vals)
          (error "Too few arguments supplied" 
                 vars 
                 vals))))

; (define (lookup-variable-value var env)
;   (define (env-loop env)
;     (define (scan vars vals)
;       (cond ((null? vars)
;              (env-loop 
;               (enclosing-environment env)))
;             ((eq? var (car vars))
;              (car vals))
;             (else (scan (cdr vars) 
;                         (cdr vals)))))
;     (if (eq? env the-empty-environment)
;         (error "Unbound variable" var)
;         (let ((frame (first-frame env)))
;           (scan (frame-variables frame)
;                 (frame-values frame)))))
;   (env-loop env))

; (define (set-variable-value! var val env)
;   (define (env-loop env)
;     (define (scan vars vals)
;       (cond ((null? vars)
;              (env-loop 
;               (enclosing-environment env)))
;             ((eq? var (car vars))
;              (set-car! vals val))
;             (else (scan (cdr vars) 
;                         (cdr vals)))))
;     (if (eq? env the-empty-environment)
;         (error "Unbound variable: SET!" var)
;         (let ((frame (first-frame env)))
;           (scan (frame-variables frame)
;                 (frame-values frame)))))
;   (env-loop env))

; (define (define-variable! var val env)
;   (let ((frame (first-frame env)))
;     (define (scan vars vals)
;       (cond ((null? vars)
;              (add-binding-to-frame! 
;               var val frame))
;             ((eq? var (car vars))
;              (set-car! vals val))
;             (else (scan (cdr vars) 
;                         (cdr vals)))))
;     (scan (frame-variables frame)
;           (frame-values frame))))

(define (traverse var env on-frame-end  on-find on-env-end)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (on-frame-end))
            ((eq? var (car vars))
             (on-find vars vals))
            (else (scan (cdr vars) 
                        (cdr vals)))))
    (if (eq? env the-empty-environment)
        (on-env-end var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (lookup-variable-value var env)
  (traverse var
            env
            (lambda ()
              (lookup-variable-value
               var
               (enclosing-environment env)))
            (lambda (vars vals)
              (car vals))
              ; (if (eq? (car vals) '*unassigned*)
              ;     (error "*unassigned*")
              ;     (car vals)))
            (lambda (var) (error "Unbound variable" var))))

(define (set-variable-value! var val env)
  (traverse var
            env
            (lambda ()
              (set-variable-value!
               var
               val
               (enclosing-environment env)))
            (lambda (vars vals) (set-car! vals val))
            (lambda (var) (error "Unbound variable: SET!" var))))

(define (define-variable! var val env)
  (traverse var
            env
            (lambda ()
              (add-binding-to-frame!
               var
               val
               (first-frame env)))
            (lambda (vars vals) (set-car! vals val))
            (lambda (var)
              (add-binding-to-frame!
               var
               val
               (first-frame env)))))

(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan vars vals pre-vars pre-vals)
      (cond ((null? vars)
             (error "Unbound variable: MAKE-UNBOUND!" var))
            ((eq? var (car vars))
             (cons (append pre-vars (cdr vars))
                   (append pre-vals (cdr vals))))
            (else (scan (cdr vars) (cdr vals)
                        (append pre-vars (list (car vars)))
                          (append pre-vals (list (car vals)))))))
    
    (let ((new-frame (scan (frame-variables frame)
                           (frame-values frame)
                           '()
                           '())))
      (set-car! frame (car new-frame))
      (set-cdr! frame (cdr new-frame)))))
