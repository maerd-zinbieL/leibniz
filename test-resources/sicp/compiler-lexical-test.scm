;;;test using gambitc
(load "~/.config/gambitc/mit-scheme-compatible.scm")

(load "compiler-lexical-address.scm")
(load "eceval-support.scm")
(load "regsim.scm")

(define (test-compiler src target linkage)
  (let ((compiled (compile src target linkage empty-compile-env)))
    (set! label-counter 0)
    (caddr compiled)))

(define eceval-operations
  (list
   ;;primitive Scheme operations
   (list 'read read)			;used by eceval
   (list 'print write-line)
   ;;used by compiled code
   (list 'list list)
   (list 'cons cons)

   ;;operations in syntax.scm
   (list 'self-evaluating? self-evaluating?)
   (list 'quoted? quoted?)
   (list 'text-of-quotation text-of-quotation)
   (list 'variable? variable?)
   (list 'assignment? assignment?)
   (list 'assignment-variable assignment-variable)
   (list 'assignment-value assignment-value)
   (list 'definition? definition?)
   (list 'definition-variable definition-variable)
   (list 'definition-value definition-value)
   (list 'lambda? lambda?)
   (list 'lambda-parameters lambda-parameters)
   (list 'lambda-body lambda-body)
   (list 'if? if?)
   (list 'if-predicate if-predicate)
   (list 'if-consequent if-consequent)
   (list 'if-alternative if-alternative)
   (list 'begin? begin?)
   (list 'begin-actions begin-actions)
   (list 'last-exp? last-exp?)
   (list 'first-exp first-exp)
   (list 'rest-exps rest-exps)
   (list 'application? application?)
   (list 'operator operator)
   (list 'operands operands)
   (list 'no-operands? no-operands?)
   (list 'first-operand first-operand)
   (list 'rest-operands rest-operands)

   ;;operations in eceval-support.scm
   (list 'true? true?)
   (list 'false? false?)		;for compiled code
   (list 'make-procedure make-procedure)
   (list 'compound-procedure? compound-procedure?)
   (list 'procedure-parameters procedure-parameters)
   (list 'procedure-body procedure-body)
   (list 'procedure-environment procedure-environment)
   (list 'extend-environment extend-environment)
   (list 'lookup-variable-value lookup-variable-value)
   (list 'set-variable-value! set-variable-value!)
   (list 'define-variable! define-variable!)
   (list 'primitive-procedure? primitive-procedure?)
   (list 'apply-primitive-procedure apply-primitive-procedure)
   (list 'prompt-for-input prompt-for-input)
   (list 'announce-output announce-output)
   (list 'user-print user-print)
   (list 'empty-arglist empty-arglist)
   (list 'adjoin-arg adjoin-arg)
   (list 'last-operand? last-operand?)
   (list 'no-more-exps? no-more-exps?)	;for non-tail-recursive machine
   (list 'get-global-environment get-global-environment)

   ;;for compiled code (also in eceval-support.scm)
   (list 'make-compiled-procedure make-compiled-procedure)
   (list 'compiled-procedure? compiled-procedure?)
   (list 'compiled-procedure-entry compiled-procedure-entry)
   (list 'compiled-procedure-env compiled-procedure-env)

   ;lexical address
   (list 'lexical-address-lookup lexical-address-lookup)
   (list 'lexical-address-set! lexical-address-set!)
   ))

;;;test
(define (compiler-test-in-machine src)
  (let ((instructions
         (cons '(assign env (op get-global-environment))
               (cons '(assign continue (label done))
                     (append
                      (test-compiler src 'val 'next)
                      (list 'done))))))
    (let ((compiler-test-machine
           (make-machine
           '(exp env val proc argl continue)
           eceval-operations
           instructions)))
      (start compiler-test-machine)
      (write-line (get-register-contents compiler-test-machine 'val)))))

(define src0
   '(begin
      (define (fib n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2)))))
      (fib 10)))

(define src1
  '(begin
     (define res 0)
     (define (sum n)
       (if (= n 0)
           res
           (begin
             (set! res (+ res n))
             (sum (- n 1)))))
     (sum 100)))

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

; (trace lexical-address-set!)
; (trace lexical-address-lookup)
; (compiler-test-in-machine src3)
; (test-compiler src 'val 'next)