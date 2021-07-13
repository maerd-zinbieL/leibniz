(load "env.scm")
(load "thunk.scm")

(define apply-in-underlying-scheme apply)

;;;number & string
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))


;;;variable
(define (variable? exp) (symbol? exp))


;;;quotation
(define (quoted? exp)
  (or (tagged-list? exp 'quote)
      (tagged-list? exp 'list)))

(define (elements exp)
  (if (tagged-list? exp 'quote)
      (cadr exp)
      (cdr exp)))

(define (text-of-quotation exp env)  
    (let ((text (elements exp)))
      (if (pair? text) 
          (actual-value (text->lazy-list text) env) 
          text)))

 (define (text->lazy-list exp) 
     (if (null? exp) 
         (list 'quote '()) 
         (list 'cons 
               (list 'quote (car exp)) 
               (text->lazy-list (cdr exp))))) 


;;;assignment
(define (assignment? exp)
  (tagged-list? exp 'set!))
(define (assignment-variable exp) 
  (cadr exp))
(define (assignment-value exp) (caddr exp))
(define (eval-assignment exp env)
  (set-variable-value! 
   (assignment-variable exp)
   (eval (assignment-value exp) env)
   env)
  "#assignment"
  )


;;;definition
(define (definition? exp)
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda 
       (cdadr exp)   ; formal parameters
       (cddr exp)))) ; body
(define (eval-definition exp env)
  (define-variable! 
    (definition-variable exp)
    (eval (definition-value exp) env)
    env)
  "#definition"
  )


;;;lambda
(define (lambda? exp) 
  (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))


;;;if
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))
(define (make-if predicate 
                 consequent 
                 alternative)
  (list 'if 
        predicate 
        consequent 
        alternative))
(define (eval-if exp env)
  (if (true? (actual-value (if-predicate exp) 
                           env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))


;;;begin
(define (begin? exp) 
  (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))
(define (eval-sequence exps env)
  (cond ((last-exp? exps) 
         (eval (first-exp exps) env))
        (else 
         (eval (first-exp exps) env)
         (eval-sequence (rest-exps exps) 
                        env))))


;;;application
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))
; (define (list-of-values exps env)
;   (if (no-operands? exps)
;       '()
;       (cons (eval (first-operand exps) env)
;             (list-of-values 
;              (rest-operands exps) 
;              env))))
(define (list-of-arg-values exps env)
  (if (no-operands? exps)
      '()
      (cons (actual-value 
             (first-operand exps) 
             env)
            (list-of-arg-values 
             (rest-operands exps)
             env))))

(define (list-of-delayed-args exps env)
  (if (no-operands? exps)
      '()
      (cons (delay-it 
             (first-operand exps) 
             env)
            (list-of-delayed-args 
             (rest-operands exps)
             env))))


;;;bool
(define true #t)
(define false #f)
(define (true? x)
  (not (eq? x false)))
(define (false? x)
  (eq? x false))


;;;procedure
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))


;;;cond
(define (cond? exp) 
  (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) 
  (car clause))
(define (cond-actions clause) 
  (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
      'false     ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp 
                 (cond-actions first))
                (error "ELSE clause isn't 
                        last: COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp 
                      (cond-actions first))
                     (expand-clauses 
                      rest))))))