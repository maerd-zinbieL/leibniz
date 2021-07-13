(load "env-pair-frame.scm")


;;;amb
(define (amb? exp)
  (tagged-list? exp 'amb))

(define (amb-choices exp)
  (cdr exp))

(define (analyze-amb exp)
  (let ((cprocs
         (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((car choices) 
             env
             succeed
             (lambda ()
               (try-next (cdr choices))))))
      (try-next cprocs))))


;;;ramb
(define (ramb? exp)
  (tagged-list? exp 'ramb))

(define (ramb-choices exp)
  (shuffle (cdr exp)))

(define (shuffle ls)
  (define (random-choose ls)
    (list-ref ls (random (length ls))))
  (define (remove x ls)
    (cond ((null? ls) ls)
          ((equal? x (car ls))
           (cdr ls))
          (else(cons (car ls) (remove x (cdr ls))))))
  (define (inner-shuffle ls)
    (if (null? ls)
        ls
        (let ((x (random-choose ls)))
          (cons x (inner-shuffle (remove x ls))))))
  (inner-shuffle ls))
      
(define (analyze-ramb exp)
  (let ((cprocs
         (map analyze (ramb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((car choices) 
             env
             succeed
             (lambda ()
               (try-next (cdr choices))))))
      (try-next cprocs))))


;;;number & string & bool
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        ((eq? exp '#t) true)
        ((eq? exp '#f) true)
        (else false)))

(define (analyze-self-evaluating exp)
  (lambda (env succeed fail)
    (succeed exp fail)))


;;;variable
(define (variable? exp) (symbol? exp))

(define (analyze-variable exp)
  (lambda (env succeed fail)
    (succeed (lookup-variable-value exp env)
             fail)))


;;;quotation
(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp)
  (cadr exp))

(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env succeed fail)
      (succeed qval fail))))


;;;assignment
(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp) 
  (cadr exp))

(define (assignment-value exp) (caddr exp))

(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze 
                (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)    ; *1*
               (let ((old-value
                      (lookup-variable-value 
                       var 
                       env)))
                 (set-variable-value!
                  var 
                  val 
                  env)
                 (succeed 
                  'ok
                  (lambda ()    ; *2*
                    (set-variable-value! 
                     var
                     old-value
                     env)
                    (fail2)))))
               fail))))

(define (permanent-set? exp)
  (tagged-list? exp 'permanent-set!)) 
  
(define (analyze-permanent-set exp) 
  (let ((var (assignment-variable exp)) 
         (vproc (analyze (assignment-value exp)))) 
    (lambda (env succeed fail) 
      (vproc env 
             (lambda (val fail2) 
               (set-variable-value! var val env) 
               (succeed 'ok  fail2)) 
             fail)))) 

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

(define (make-define name value)
    (list 'define name value))

(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze 
                (definition-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
               (define-variable! var val env)
               (succeed 'ok fail2))
             fail))))


;;;lambda
(define (lambda? exp) 
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence 
                (lambda-body exp))))
    (lambda (env succeed fail)
      (succeed (make-procedure vars bproc env)
               fail))))


;;;if
(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (make-if predicate consequent alternative)
  (list 'if  predicate  consequent  alternative))

(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env succeed fail)
      (pproc env
             ;; success continuation for evaluating
             ;; the predicate to obtain pred-value
             (lambda (pred-value fail2)
               (if (true? pred-value)
                   (cproc env succeed fail2)
                   (aproc env succeed fail2)))
             ;; failure continuation for
             ;; evaluating the predicate
             fail))))



;;;begin & sequence
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

; (define (analyze-sequence exps)
;   (define (sequentially proc1 proc2)
;     (lambda (env) (proc1 env) (proc2 env)))
;   (define (loop first-proc rest-procs)
;     (if (null? rest-procs)
;         first-proc
;         (loop (sequentially first-proc 
;                             (car rest-procs))
;               (cdr rest-procs))))
;   (let ((procs (map analyze exps)))
;     (if (null? procs)
;         (error "Empty sequence: ANALYZE"))
;     (loop (car procs) (cdr procs))))
(define (analyze-sequence exps)
  (define (sequentially a b)
    (lambda (env succeed fail)
      (a env
         ;; success continuation for calling a
         (lambda (a-value fail2)
           (b env succeed fail2))
         ;; failure continuation for calling a
         fail)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc 
                            (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence: ANALYZE"))
    (loop (car procs) (cdr procs))))


;;;bool
;下面两行为了兼容gambit
(define true #t)

(define false #f)

(define (true? x)
  (not (eq? x false)))

(define (false? x)
  (eq? x false))


;;;application
(define (application? exp) (pair? exp))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (no-operands? ops) (null? ops))

(define (first-operand ops) (car ops))

(define (rest-operands ops) (cdr ops))

(define (make-application-call proc-name args)
  (cons proc-name args))

(define (get-args aprocs env succeed fail)
  (if (null? aprocs)
      (succeed '() fail)
      ((car aprocs) 
       env
       ;; success continuation for this aproc
       (lambda (arg fail2)
         (get-args 
          (cdr aprocs)
          env
          ;; success continuation for
          ;; recursive call to get-args
          (lambda (args fail3)
            (succeed (cons arg args)
                     fail3))
          fail2))
       fail)))

(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env succeed fail)
      (fproc env
             (lambda (proc fail2)
               (get-args 
                aprocs
                env
                (lambda (args fail3)
                  (execute-application
                   proc args succeed fail3))
                fail2))
             fail))))


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
