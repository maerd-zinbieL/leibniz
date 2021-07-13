(load "regsim.scm")
(define (make-register name)
  (let ((contents '*unassigned*)
        (trace-on? #f))
    (define (dispatch message)
      (cond ((eq? message 'get) contents)
            ((eq? message 'set)
             (lambda (value)
               (if trace-on?
                   (write-line
                    (list 'register-name '= name
                          'old-value '= contents
                          'new-value '= value)))
               (set! contents value)))
            ((eq? message 'trace-on)
             (set! trace-on? #t))
            ((eq? message 'trace-off)
             (set! trace-on? #f))
            (else
             (error "Unknown request -- REGISTER" message))))
    dispatch))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '()))
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))
                 ;;**next for monitored stack (as in section 5.2.4)
                 ;;  -- comment out if not wanted
                 (list 'print-stack-statistics
                       (lambda () (stack 'print-statistics)))))
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
              ((eq? message 'register-trace-on)
               (lambda (name)
                 ((lookup-register name) 'trace-on)))
              ((eq? message 'register-trace-off)
               (lambda (name)
                 ((lookup-register name) 'trace-off)))
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
       (goto (label start))
       )))

((test-machine 'register-trace-on) 'val)
((test-machine 'register-trace-on) 'n)
; ((test-machine 'register-trace-on) 'continue)
(start test-machine)
