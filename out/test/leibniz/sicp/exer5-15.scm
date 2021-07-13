(load "regsim.scm")
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (insts-count 0)
        (the-instruction-sequence '()))
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))
                 (list 'print-stack-statistics
                       (lambda () (stack 'print-statistics)))
                 (list 'print-instructions-statistics
                       (lambda ()
                         (newline)
                         (display (list 'instructions-count '= insts-count))
                         (set! insts-count 0)))
                 ))
          (register-table
           (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
            (set! register-table
                  (cons (list name (make-register name))
                        register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                (set! insts-count (+ insts-count 1))
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define test-machine
  (make-machine
   '(n val continue)
   (list (list '= =)
         (list '- -)
         (list '* *)
         (list 'read read)
         (list 'print display)
         )
   '(
     start
       (perform (op initialize-stack))
       (perform (op print) (const "\nenter n: "))
       (assign n (op read))
       (assign continue (label fact-done))   ; set up final return address
     fact-loop
       (test (op =) (reg n) (const 1))
       (branch (label base-case))
       (save continue)                       ; Set up for the recursive call
       (save n)                              ; by saving n and continue.
       (assign n (op -) (reg n) (const 1))   ; Set up continue so that the
       (assign continue (label after-fact))  ; computation will continue
       (goto (label fact-loop))              ; at after-fact when the
      after-fact                              ; subroutine returns.
       (restore n)
       (restore continue)
       (assign val (op *) (reg n) (reg val)) ; val now contains n(n - 1)!
       (goto (reg continue))                 ; return to caller
     base-case
       (assign val (const 1))                ; base case: 1! = 1
       (goto (reg continue))                 ; return to caller
      fact-done
       (perform (op print) (const "result: "))
       (perform (op print) (reg val))
       (perform (op print-stack-statistics))
       (perform (op print-instructions-statistics))
       (goto (label start))
       )))
(start test-machine)