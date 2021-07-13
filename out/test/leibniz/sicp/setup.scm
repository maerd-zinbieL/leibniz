(load "core.scm")

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'pair? pair?)
        (list 'null? null?)
        (list 'list list)
        
        (list 'eq? eq?)
        (list 'equal? equal?)
        (list 'number? number?)
        (list 'string? string?)
        (list 'symbol? symbol?)
        (list 'integer? integer?)
        (list 'sqrt sqrt)
        (list 'pair? pair?)
        (list 'length length)
 
        (list 'display display)
        (list 'newline newline)
        (list 'square (lambda (x) (* x x)))
        (list 'remainder remainder)
        (list 'not not )
        (list 'runtime runtime)
        ; (list 'and and)
        ; (list 'or or)
        (list 'append append)
        (list 'memq memq)
        (list 'member member)
        (list 'not not)
        (list 'abs abs)

        (list '= =)
        (list '> >)
        (list '< <)
        (list '<= <=)
        (list '>= >=)
        (list '+ + )
        (list '- - )
        (list '* * )
        (list '/ / )
        
        (list 'exit exit)
        (list 'load load) 
        ))

(define (primitive-procedure-names)
  (map car primitive-procedures))

(define (primitive-implementation proc) 
  (cadr proc))

(define (primitive-procedure-objects)
  (map (lambda (proc) 
         (list 'primitive (cadr proc)))
       primitive-procedures))

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
   (primitive-implementation proc) args))

(define (setup-environment)
  (let ((initial-env
         (extend-environment 
          (primitive-procedure-names)
          (primitive-procedure-objects)
          the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    (ambeval '(define (require p) (if (not p) (amb)))
             initial-env
             (lambda (a b) #t)
             (lambda () #t))
    (ambeval '(define (an-element-of items)
                (require (not (null? items)))
                (amb (car items) 
                     (an-element-of (cdr items))))
             initial-env
             (lambda (a b) #t)
             (lambda () #t))
     (ambeval '(define (distinct? items)
                 (cond ((null? items) true)
                       ((null? (cdr items)) true)
                       ((member (car items) (cdr items)) false)
                       (else (distinct? (cdr items)))))
              initial-env
             (lambda (a b) #t)
             (lambda () #t))
     (ambeval '(define (map proc s)
                 (if (null? s)
                     '()
                     (cons (proc (car s))
                           (map proc (cdr s)))))
              initial-env
              (lambda (a b) #t)
              (lambda () #t))
              
    initial-env))

(define the-global-environment 
  (setup-environment))

