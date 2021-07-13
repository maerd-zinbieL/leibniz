(define (extend-compile-env vals base-env)
  (cons vals base-env))

(define empty-compile-env '())

(define (empty-compile-env? compile-env)
  (null? compile-env))

(define (first-compile-env compile-env)
  (car compile-env))

(define (rest-compile-env compile-env)
  (cdr compile-env))

(define (find-variable var compile-env)
  (define (scan-vals var vars var-index)
    (cond ((null? vars)
           #f)
          ((eq? var (car vars))
           var-index)
          (else (scan-vals var (cdr vars) (+ var-index 1)))))
  (define (scan-env frame-index compile-env)
    (if (empty-compile-env? compile-env)
        'not-found
        (let ((var-index
               (scan-vals var (first-compile-env compile-env) 0)))
          (if var-index
              (cons frame-index var-index)
              (scan-env (+ frame-index 1)
                        (rest-compile-env compile-env))))))
  (scan-env 0 compile-env))

(define (lexical-address-lookup lexical-addr env)
  (define (scan var-index vars vals)
    (cond ((null? vals)
           (error "Unbound variable --Lexical-Adress-Lookup"))
          ((= 0 var-index)
           (let ((find (car vals)))
             (if (eq? find '*unassigned*)
                 (error "Variable *Unassigned*: " (car vars))
                 find)))
          (else (scan (- var-index 1) (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
      (error "Unbound variable --Lexical-Adress-Lookup")
      (let ((frame-index (car lexical-addr))
            (var-index (cdr lexical-addr)))
        (if (= 0 frame-index)
            (let ((frame (first-frame env)))
              (scan var-index
                    (frame-variables frame)
                    (frame-values frame)))
            (let ((next-lexical-addr
                   (cons (- frame-index 1) var-index)))
              (lexical-address-lookup
               next-lexical-addr
               (enclosing-environment env)))))))
  
(define (lexical-address-set! lexical-addr val env)
  (define (scan! var-index vals)
    (cond ((null? vals)
           (error "Unbound variable --Lexical-Adress-Set!"))
          ((= 0 var-index)
           (set-car! vals val))
          (else (scan! (- var-index 1)  (cdr vals)))))
   (if (eq? env the-empty-environment)
       (error "Unbound variable --Lexical-Adress-Set!")
       (let ((frame-index (car lexical-addr))
             (var-index (cdr lexical-addr)))
         (if (= 0 frame-index)
             (let ((frame (first-frame env)))
               (scan! var-index (frame-values frame)))
             (let ((next-lexical-addr
                    (cons (- frame-index 1) var-index)))
               (lexical-address-lookup
                next-lexical-addr
                (enclosing-environment env)))))))