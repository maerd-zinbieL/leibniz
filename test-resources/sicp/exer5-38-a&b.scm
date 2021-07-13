(load "compiler-test.scm")
(define (spread-arguments operands)
  (let ((operand-code-1
         (compile (car operands) 'arg1 'next))
        (operand-code-2
         (compile (cadr operands) 'arg2 'next)))
    (list operand-code-1 operand-code-2)))

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((open-code? exp)
         (compile-open-code exp target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

(define (open-code? exp) (memq (operator exp) '(+ - * / =)))

(define (compile-open-code exp target linkage)
  (let ((operands-code (spread-arguments (operands exp)))
        (op (operator exp)))
    (end-with-linkage linkage
      (append-instruction-sequences
        (cadr operands-code)       
        (preserving '(arg2)
            (car operands-code)
            (make-instruction-sequence '(arg1 arg2) (list target)
             `((assign ,target (op ,op) (reg arg1) (reg arg2)))))))))

;;;test
(load "regsim.scm")

(define (make-arithmetic-machine arithmetic)
  (make-machine
   '(val argl arg1 arg2 proc env continue)
   (list (list '+ +)
         (list '* *)
         (list '- -)
         (list '/ /)
         (list '= =)
         (list 'list list)
         (list 'cons cons)
         (list 'car car)
         (list 'cadr cadr))
   (test-compiler arithmetic 'val 'next)
  ))


(define (test arithmetic)
  (let ((arithmetic-machine
         (make-arithmetic-machine arithmetic)))
    (start arithmetic-machine)
    (let ((result (get-register-contents arithmetic-machine 'val))
          (true-answer (eval arithmetic user-initial-environment)))
      (if (= result true-answer)
          result
          #f))))

