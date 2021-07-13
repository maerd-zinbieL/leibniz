(load "derived-exp.scm")

(define (ambeval exp env succeed fail)
  ((analyze exp) env succeed fail))

(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) 
         (analyze-quoted exp))
        ((variable? exp) 
         (analyze-variable exp))
        ((assignment? exp) 
         (analyze-assignment exp))
        ((definition? exp) 
         (analyze-definition exp))
        ((if? exp) 
         (analyze-if exp))
        ((and? exp) 
         (analyze-and exp))
        ((or? exp) 
         (analyze-or exp))
        ((lambda? exp) 
         (analyze-lambda exp))
        ((begin? exp) 
         (analyze-sequence 
          (begin-actions exp)))
        ((cond? exp) 
         (analyze (cond->if exp)))
        ((let? exp)
         (analyze (let->combination exp)))
        ((amb? exp) (analyze-amb exp))
        ((ramb? exp) (analyze-ramb exp))
        ((permanent-set? exp)
         (analyze-permanent-set exp)) 
        ((application? exp) 
         (analyze-application exp))
        (else
         (error "Unknown expression 
                 type: ANALYZE" 
                exp))))

(define (execute-application 
         proc args succeed fail)
  (cond ((primitive-procedure? proc)
         (succeed 
          (apply-primitive-procedure 
           proc args)
          fail))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment 
           (procedure-parameters proc)
           args
           (procedure-environment proc))
          succeed
          fail))
        (else (error "Unknown procedure type: 
                      EXECUTE-APPLICATION"
                     proc))))

