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