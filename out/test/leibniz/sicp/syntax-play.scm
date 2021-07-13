(load "setup.scm")
;;;let*
; (define (make-let clauses body)
;     (list 'let clauses body))
; (define (let*-clauses exp) (cadr exp))
; (define (let*-body exp) (caddr exp))
; (define (first-clause clauses) (car clauses))
; (define (rest-clauses clauses) (cdr clauses))
; (define (no-clauses? clauses) (null? clauses))
; (define (expand-clauses clauses body)
;   (if (no-clauses? clauses)
;       body
;       (make-let
;         (list (first-clause clauses))
;         (expand-clauses (rest-clauses clauses) body))))
; (define (let*->nested-lets exp)
;   (expand-clauses (let*-clauses exp) (let*-body exp)))

; (define exp '(let* ((x 3)
;                     (y (+ x 2))
;                     (z (+ x y 5)))
;                (* x z)))
;;;(display (let*->nested-lets exp))



;;;exercise 4-8
; (let fib-iter ((a 1) (b 0) (count 10))
;     (if (= count 0)
;         b
;         (fib-iter (+ a b) 
;                   a 
;                   (- count 1))))
; (begin
;   (define fib-iter
;     (lambda (a b count)
;       (if (= count 0)
;             b
;             (fib-iter (+ a b) 
;                   a 
;                   (- count 1)))))
;   (fib-iter 1 0 10))

; ((lambda ()
;    (begin
;      (define fib-iter
;        (lambda (a b count)
;          (if (= count 0)
;              b
;              (fib-iter (+ a b) 
;                 a 
;                 (- count 1)))))
;      (fib-iter 1 0 10))))

; (let ⟨var⟩ ⟨bindings⟩ ⟨body⟩)
; (begin
;   (define <var> (lambda <binding variables> <body>))
;   (<var> <binding values>))
; ((lambda ()
;    (begin
;      (define <var> (lambda <binding variables> <body>))
;      (<var> <binding values>))))

; (define (begin-actions exp) (cdr exp))
; (define (last-exp? seq) (null? (cdr seq)))
; (define (first-exp seq) (car seq))
; (define (rest-exps seq) (cdr seq))
; (define (make-lambda parameters body)
;   (cons 'lambda (cons parameters body)))
; (define (make-begin seq) (cons 'begin seq))
; (define (sequence->exp seq)
;     (cond ((null? seq) seq)
;           ((last-exp? seq) (first-exp seq))
;           (else (make-begin seq))))
; (define (named-let? exp) (symbol? (car exp)))
; (define (let-clauses exp)
;   (if (named-let? exp)
;       (caddr exp)
;       (cadr exp)))
; (define (let-body exp)
;   (if (named-let? exp)
;       (cdddr exp)
;       (cddr exp)))
; (define (first-clause clauses) (car clauses))
; (define (rest-clauses clauses) (cdr clauses))
; (define (clause-var clause) (car clause))
; (define (clause-exp clause) (cadr clause))
; (define (make-define name value)(list 'define value))
; (define (let->combination exp)
;   (define (make-call proc-name args) (cons proc-name args))
;   (let ((clauses (let-clauses exp))
;           (body (let-body exp)))
;       (let ((vars (map clause-var clauses))
;             (exps (map clause-exp clauses)))
;         (if (named-let? exp)
;             (list
;              (make-lambda
;                '()
;                (list (sequence->exp
;                       (list (make-define (cadr exp)
;                                          (make-lambda vars body))
;                             (make-call (cadr exp) exps))))))
;              (cons (make-lambda vars body) exps)))))
    
; (define exp
;   '(let fib-iter ((a 1) (b 0) (count 10))
;     (if (= count 0)
;         b
;         (fib-iter (+ a b) 
;                   a 
;                   (- count 1)))))
; (display (let->combination exp))
; (newline)

; (define sequence->exp (get 'sequence->exp 'begin))
; (define make-begin (get 'make-begin 'begin))
; (define make-define (get 'make-define 'define))
; (define make-lambda (get 'make-lambda 'lambda))
; (define make-if (get 'make-if 'if))
; (define (while-predicate exp) (cadr exp))
; (define (while-actions exp) (cddr exp))
; (define (wrap-with-lambda exp) (list (make-lambda '() (sequence->exp exp))))
;   (define (while->combination exp)
;     (let ((proc-name 'while-proc))
;       (wrap-with-lambda
;         (list
;          (list (make-define proc-name
;                             (make-lambda
;                               '()
;                               (list (make-if (while-predicate exp)
;                                        (append
;                                         (cons 'begin (while-actions exp))
;                                         (list (list proc-name)))
;                                        "#while"))))
;                (make-application-call proc-name '()))))))

; (define exp '(while (< i 10) (display i) (set! i (+ i 1))))


; (define (ub! var frame)
;   (define (scan vars vals pre-vars pre-vals)
;     (cond ((null? vars)
;            (error "Unbound variable: MAKE-UNBOUND!"))
;           ((eq? var (car vars))
;              (cons (append pre-vars (cdr vars))
;                    (append pre-vals (cdr vals))))
;           (else (scan (cdr vars) (cdr vals)
;                       (append pre-vars (list (car vars)))
;                       (append pre-vals (list (car vals)))))))
  
;   (let ((new-frame (scan (frame-variables frame)
;                          (frame-values frame)
;                          '()
;                          '())))
;     (set-car! frame (car new-frame))
;     (set-cdr! frame (cdr new-frame))))
; (define (ub! var frame)
;   (define (scan bindings pre-bindings)
;     (cond ((null? bindings)
;            (error "Unbound variable: MAKE-UNBOUND!" var))
;           ((eq? var (caar bindings))
;            (append pre-bindings (cdr bindings)))
;           (else (scan (cdr bindings)
;                       (append pre-bindings
;                               (list (car bindings)))))))
;     (let ((new-bindings
;            (scan (frame-bindings frame) '())))
;       (set-cdr! frame new-bindings)))

; (define f1 (make-frame '() '()))
; (define f2 (make-frame '(x) '(1)))
; (define f3 (make-frame '(x y z) '(1 2 3)))

; (define (remove e li pre)
;   (cond ((null? li)
;          "not exist")
;         ((eq? e (car li))
;          (append pre (cdr li)))
;         (else (remove e
;                       (cdr li)
;                       (append pre (list (car li)))))))

; (define (remove-elment e li)
;   (remove e li '()))

; (define (internal-body body) (cddr body))

; (define (all-defines internal)
;   (cond ((null? internal) '())
;   ((tagged-list? (car internal) 'define)
;    (cons (cons (definition-variable (car internal))
;                (list (definition-value (car internal))))
;          (all-defines (cdr internal))))
;   (else (all-defines (cdr internal)))))

; (define (value-exprs internal)
;   (cond ((null? internal) '())
;   ((tagged-list? (car internal) 'define)
;    (value-exprs (cdr internal)))
;   (else (cons (car internal)
;               (value-exprs (cdr internal))))))

; (define (scan-out-defines body)
;   (let ((defines (all-defines body))
;         (values (value-exprs  body)))
;     (if (null? defines)
;      body
;      (list (make-let
;       (map (lambda (p)
;              (list (car p)
;                    '*unassigned*))
;            defines)
;       (sequence->exp
;        (append (map (lambda (p)
;                       (list 'set! (car p) (cadr p)))
;                     defines)
;                values)))))))


; (define exp0
;   '(
;      (+ 1 1)
;      (define (even? n)
;        (if (= n 0)
;         true
;         (odd? (- n 1))))
;      (even? n)
;      (define (odd? n)
;        (if (= n 0)
;         false
;         (even? (- n 1)))))
;   )

; (define exp1
;   '(
;      (define u (e1))
;      (+ 1 1)
;      (define v (e2))
;      (e3))
; )
; (define exp2 '((lambda (x) (* x x)) x))

; (define fib
;     (lambda (n)
;       (define (fib-iter a b count)
;           (if (= count 0)
;           b
;           (fib-iter (+ a b) a (- count 1))))
;       (fib-iter 1 0 n)))

; ; (define fib
; ;     (lambda (n)
; ;       (let ((fib-iter '*unassigned*))
; ;         (set! fib-iter
; ;               (lambda (a b count)
; ;                 (if (= count 0)
; ;                 b
; ;                 (fib-iter (+ a b) a (- count 1)))))
; ;         (fib-iter 1 0 n))))

; ; (define fib
; ;     (lambda (n)
; ;       (let fib-iter ((a 1) (b 0) (count n))
; ;         (if (= count 0)
; ;             b
; ;             (fib-iter (+ a b) 
; ;                   a 
; ;                   (- count 1))))))

; ; (let ((a 1))
; ;   (define (f x)
; ;     (define b (+ a x))
; ;     (define a 5)
; ;     (+ a b))
; ;   (f 10))

; ; (let ((a 1)
; ;       (f '*unassigned))
; ;   (set! f
; ;         (lambda (x)
; ;           (let ((b '*unassigned)
; ;                 (a '*unassigned))
; ;             (set! b (+ a x))
; ;             (set! a 5)
; ;             (+ a b))))
; ;   (f 10))

; (define (f x)
;   (define (even? n)
;     (if (= n 0)
;         true
;         (odd? (- n 1))))
;   (define (odd? n)
;     (if (= n 0)
;         false
;         (even? (- n 1))))
;   (even? x))

; (define (f x)
;   (let ((even? '*unassigned)
;         (odd? '*unassigned))
;     (set! even?
;           (lambda (n)
;              (if (= n 0)
;                  true
;                  (odd? (- n 1)))))
;     (set! odd?
;           (lambda (n)
;             (if (= n 0)
;                 false
;                 (even? (- n 1)))))
;     (even? x)))

;  (define (letrec? expr) (tagged-list? expr 'letrec)) 
;  (define (letrec-inits expr) (cadr expr)) 
;  (define (letrec-body expr) (cddr expr)) 
;  (define (declare-variables expr) 
;          (map (lambda (x) (list (car x) '*unassigned*)) (letrec-inits expr))) 
;  (define (set-variables expr) 
;          (map (lambda (x) (list 'set! (car x) (cadr x))) (letrec-inits expr))) 
;  (define (letrec->let expr) 
;          (list 'let (declare-variables expr)  
;                 (make-begin (append (set-variables expr) (letrec-body expr)))))


; (define (letrec->let exp)
;   (let ((vars (letrec-binding-vars exp))
;         (vals (letrec-binding-vals exp)))
;     (make-let (make-unassigned-bindings vars)
;               (append (make-set-clauses vars vals)
;                       (letrec-body exp)))))

; (define exp
;   '(letrec
;        ((even?
;          (lambda (n)
;            (if (= n 0)
;                true
;                (odd? (- n 1)))))
;         (odd?
;          (lambda (n)
;            (if (= n 0)
;                false
;                (even? (- n 1))))))
;      (even? 10))
; )