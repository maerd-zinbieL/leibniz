
;;;一些help functions
(define (extend-compile-env vals base-env)
  (cons vals base-env))

(define empty-compile-env '())

(define (empty-compile-env? compile-env)
  (null? compile-env))

(define (first-compile-env compile-env)
  (car compile-env))

(define (rest-compile-env compile-env)
  (cdr compile-env))

;;;修改compile-lambda-body
(define (compile-lambda-body exp proc-entry compile-env)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
     (make-instruction-sequence '(env proc argl) '(env)
      `(,proc-entry
        (assign env (op compiled-procedure-env) (reg proc))
        (assign env
                (op extend-environment)
                (const ,formals)
                (reg argl)
                (reg env))))
     (compile-sequence
        (lambda-body exp)
        'val 'return
        (extend-compile-env formals compile-env)))))

;;;其余的是些重复的脑力工作，修改的代码有点多，如果有工具做静态检查就好了。