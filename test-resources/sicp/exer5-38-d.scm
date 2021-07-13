(load "exer5-38-a&b.scm")

(define (compile-open-code-2-args exp target linkage)
  (let ((operands-code (spread-arguments (operands exp)))
        (op (operator exp)))
    (end-with-linkage linkage
      (append-instruction-sequences
        (cadr operands-code) 
        (preserving '(arg2)
          (car operands-code)
          (make-instruction-sequence '(arg1 arg2) (list target)
            `((assign ,target (op ,op) (reg arg1) (reg arg2)))))))))

;;;idea is from https://www.inchmeal.io/sicp/ch-5/ex-5.38.html
;;: compile (+ 1 2 3 4 5): compile (+ 1 2) and compile (+ 3 4 5) then (+ result-1 result-2).
;;; special case: (+ 1 2 3) should be splitted as (+ 1 2) and 3(not + 3)
(define (compile-open-code exp target linkage)
  (let ((exp-op (operator exp))
        (exp-operands (operands exp)))
    (cond ((= (length exp-operands) 0)
           (cond ((eq? exp-op '+)
                  (end-with-linkage linkage
                    (make-instruction-sequence '() `(,target)
                     `((assign ,target (const 0))))))
                 ((eq? exp-op '*)
                  (end-with-linkage linkage
                    (make-instruction-sequence '() `(,target)
                     `((assign ,target (const 1))))))
                 (else (error "Unknow open code expression --Compile-Open-Code" exp))))
          ((= (length exp-operands) 1)
           (compile (car exp-operands) target linkage))
          (else (let ((first-2-operands (take exp-operands 2))
                      (rest-operands (cddr exp-operands)))
                  (let ((compiled-first-2
                         (compile-open-code-2-args (cons exp-op first-2-operands) 'arg1 'next))
                        (compiled-rest
                         (compile-open-code (cons exp-op rest-operands) 'arg2 'next)))
                    (end-with-linkage linkage
                      (append-instruction-sequences
                        compiled-rest
                        (preserving '(arg2)
                           compiled-first-2
                           (make-instruction-sequence '(arg1 arg2) (list target)
                             `((assign ,target (op ,exp-op) (reg arg1) (reg arg2)))))))))))))

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