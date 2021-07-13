(load "basic-exp.scm")


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
        (cond ((cond-else-clause? first)
               (if (null? rest)
                   (sequence->exp
                    (cond-actions first))
                   (error "ELSE clause isn't 
                            last: COND->IF"
                            clauses)))
              ((eq? (car (cond-actions first)) '=>)
               (if (null? (cdr (cond-actions first)))
                   (error "Ill-formed syntax: (cond (... =>) ...)")
                   (let ((test (cond-predicate first))
                         (recipient (cadr (cond-actions first))))
                     (make-if test
                              (list recipient test)
                              (expand-clauses rest)))))
              (else (make-if (cond-predicate first)
                             (sequence->exp
                              (cond-actions first))
                             (expand-clauses rest)))))))


;;;let
(define (let? exp)
  (tagged-list? exp 'let))

(define (named-let? exp) (symbol? (cadr exp)))

(define (let-clauses exp)
  (if (named-let? exp)
      (caddr exp)
      (cadr exp)))

(define (let-body exp)
  (if (named-let? exp)
      (cdddr exp)
      (cddr exp)))

(define (first-clause clauses) (car clauses))

(define (rest-clauses clauses) (cdr clauses))

(define (clause-var clause) (car clause))

(define (clause-exp clause) (cadr clause))

(define (let->combination exp)
  (let ((clauses (let-clauses exp))
        (body (let-body exp)))
    (let ((vars (map clause-var clauses))
          (exps (map clause-exp clauses)))
      (if (named-let? exp)
          (list
           (make-lambda
             '()
             (list (sequence->exp
                    (list (make-define (cadr exp)
                                       (make-lambda vars body))
                          (make-application-call (cadr exp) exps))))))
          (cons (make-lambda vars body) exps)))))

;;;and
(define (and? exp)
  (tagged-list? exp 'and))
(define (last-seq? seq) (null? (cdr seq)))
(define (and-seq exp) (cdr exp))
(define (first-seq seq) (car seq))
(define (rest-seq seq) (cdr seq))
(define (and->if exp)
  (expand-and-seq (and-seq exp)))
(define (expand-and-seq seq)
  (cond ((null? seq) true)
        ((last-seq? seq)
         (make-if (first-seq seq) (first-seq seq) false))
        (else (make-if
                (first-seq seq)
                (expand-and-seq (rest-seq seq))
                false))))
(define (analyze-and exp )
  (analyze (and->if exp)))

;;;or
(define (or? exp)
  (tagged-list? exp 'or))
(define (no-seq? seq) (null? seq))
(define (or-seq exp) (cdr exp))
(define (expand-or-seq seq)
  (if (no-seq? seq)
        false
        (make-if (first-seq seq)
                 true
                 (expand-or-seq (rest-seq seq)))))
  (define (or->if exp)
    (expand-or-seq (or-seq exp)))
(define (analyze-or exp)
  (analyze (or->if exp)))