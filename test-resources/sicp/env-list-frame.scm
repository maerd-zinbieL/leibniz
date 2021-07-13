(load "utils.scm")


;;;环境的表示
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())


;;;frame 的表示
;represent a frame as a list of bindings
; (define (make-frame variables values)
;   (map cons variables values))
;为什么上述定义不行？(add-binding-to-frame var val the-empty-frame)
(define (make-frame variables values)
  (cons 'frame
        (map cons variables values)))
(define (frame-bindings frame)
  (cdr frame))
(define (frame-variables frame)
  (map car (frame-bindings frame)))
(define (frame-values frame)
  (map cdr (frame-bindings frame)))
(define (add-binding-to-frame! var val frame)
  (let ((new-binding (cons var val)))
    (set-cdr! frame
              (cons new-binding
                    (frame-bindings frame)))))


;;;环境的操作
;represent a frame as a list of bindings
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

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop 
              (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            ;  (if (eq? (car vals)
            ;           '*unassigned*)
            ;      (error "*unassigned*")
            ;      (car vals)))
            (else (scan (cdr vars) 
                        (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan bindings)
      (cond ((null? bindings)
             (env-loop 
              (enclosing-environment env)))
            ((eq? var (caar bindings))
             (set-cdr! (car bindings) val))
            (else (scan (cdr bindings)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-bindings frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((the-frame (first-frame env)))
    (define (scan bindings)
      (cond ((null? bindings)
             (add-binding-to-frame! 
              var val the-frame))
            ((eq? var (caar bindings))
             (set-cdr! (car bindings) val))
            (else (scan (cdr bindings)))))
    (scan (frame-bindings the-frame))))

(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan bindings pre-bindings)
      (cond ((null? bindings)
             (error "Unbound variable: MAKE-UNBOUND!" var))
            ((eq? var (caar bindings))
             (append pre-bindings (cdr bindings)))
            (else (scan (cdr bindings)
                        (append pre-bindings
                                (list (car bindings)))))))
    (let ((new-bindings
           (scan (frame-bindings frame) '())))
      (set-cdr! frame new-bindings))))