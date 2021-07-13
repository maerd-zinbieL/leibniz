(define eval
  (lambda (exp env)
    (cond ((number? exp) exp)
          ((symbol? exp) (lookup exp env))
          ((eq? (car exp) 'quote) (cadr exp))
          ((eq? (car exp) 'lambda)
           (list 'CLOSURE (cdr exp) env))
          ((eq? (car exp) 'cond)
           (evcond (cdr exp) env))
          (else (apply (eval (car exp) env) 
                       (evlist (cdr exp) env))))))

(define apply
  (lambda (proc args)
    (cond ((primitive? proc)
           (apply-primop proc args))
          ((eq? (car proc) 'CLOSURE)
           (eval (cadadr proc)
                 (bind (caadr proc)
                       args
                       env)))
          (else (error "unkown type of procedure:
                       APPLY")))))

(define evlist
  (lambda (l env)
    (cond ((eq? l '()) '())
          (else (eval (car l) env)
                (evlist (cdr l) env)))))

(define evcond
  (lambda (clauses env)
    (cond ((eq? clauses '())
           '())
          ((eq? (caar clauses) 'else)
           (eval (cadar clauses) env))
          ((false? (caar clauses) env)
           (evcond (cdr clauses env)))
          (else (eval (cadar clauses) env)))))

(define bind
  (lambda (vars vals env)
    (cons (pair-up vars vals)
          env)))

(define pair-up
  (lambda (vars vals)
    (cond ((eq? vars '())
           (cond ((eq? vals '()) '())
                 (else (error "too many arguments:
                              PAIR-UP"))))
          ((eq? vals '())
           (error "too few arguments:
                                 PAIR-UP"))
          ((symbol? vars);;;不懂
           (cons (cons vars vals) '()))
          (else (cons (cons (car vals)
                            (car vals))
                      (pair-up (cdr vals)
                               (cad vals)))))))

(define lookup
  (lambda (sym env)
    (cond ((eq? env '())
           (error "Unbound variable:
                  LOOK-UP"))
          (else((lambda (vcell) ;value cell:(variable . value)
                  (cond ((eq? vcell '())
                         (lookup sym
                                 (cdr env)))
                        (else (cdr vcell))))
                (assq sym (car env)))))))

(define assq
  (lambda (sym alist)
    (cond ((eq? alist '()) '())
          ((eq? sym (caar alist))
           (car alist))
          (else (assq sym (cdr alist))))))

(define error
  (lambda (. args)
    (apply display args)))
           