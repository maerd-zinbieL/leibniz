(load "compiler-lexical-test.scm")


(define (make-let clauses body)
    (list 'let clauses body))

(define (scan-out-defines body)
    (define (all-defines internal)
        (cond ((null? internal) '())
        ((tagged-list? (car internal) 'define)
         (cons (cons (definition-variable (car internal))
                     (list (definition-value (car internal))))
               (all-defines (cdr internal))))
        (else (all-defines (cdr internal)))))
    (define (value-exprs internal)
        (cond ((null? internal) '())
        ((tagged-list? (car internal) 'define)
         (value-exprs (cdr internal)))
        (else (cons (car internal)
                    (value-exprs (cdr internal))))))
    (let ((defines (all-defines body))
          (values (value-exprs  body)))
      (if (null? defines)
          body
          (list (make-let
                  (map (lambda (p)
                         (list (car p)
                               '*unassigned*))
                       defines)
                  (sequence->exp
                   (append (map (lambda (p)
                                  (list 'set! (car p) (cadr p)))
                                defines)
                           values)))))))

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
        (scan-out-defines (lambda-body exp))
        'val 'return
        (extend-compile-env formals compile-env)))))

(define src2
  '(begin
     (define (factorial n)
       (define (iter product counter)
         (if (> counter n)
             product
             (iter (* counter product)
                   (+ counter 1))))
       (iter 1 1))
     (factorial 10)))

(define src3
  '(begin
     (define (add2 x)
       (define (add1 x)
         (+ 1 x))
       (add1 (add1 x)))
     (add2 0)))

(compiler-test-in-machine src3)