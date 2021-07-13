(load "regsim.scm")
; 将一条指令表示为：
; ((text . label) .  procedure)
; 于是就要修改或增加下面两个函数
(define (instruction-text inst)
  (caar inst))
(define (instruction-label inst)
  (cdar inst))

;;;find-label 根据指令的text找到它的label
(define (find-label inst-text label labels)
  (if (null? labels)
      label
      (if (assoc inst-text (cdar labels))
          (find-label inst-text (caar labels) (cdr labels))
          (find-label inst-text label(cdr labels)))))

;更新指令的procedure和label
(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (stack (machine 'stack))
        (ops (machine 'operations)))
    (define (update-label! inst)
      (let* ((text (car inst))
             (label (find-label text '() labels)))
        (set-car! inst (cons text label))))
    (define (update-procedure! inst)
      (set-instruction-execution-proc!
       inst
       (make-execution-procedure
        (instruction-text inst) labels machine
        pc flag stack ops)))
    (for-each
     (lambda (inst)
       (update-label! inst)
       (update-procedure! inst))
     insts)))

;修改excute函数，让它打印指令的label
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (insts-count 0)
        (trace-on? #t)
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
                 (list 'trace-off
                       (lambda ()
                         (set! trace-on? #f)))
                 (list 'trace-on
                       (lambda ()
                         (set! trace-on? #t)))
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
                (if trace-on?
                    (begin
                      (write (list 'executing
                                   '->
                                   (instruction-label (car insts))
                                   ':
                                   (instruction-text (car insts))))
                      (newline)))
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
         (list 'print write-line)
         )
   '(
       (perform (op print) (const "no label"))
       (perform (op print) (const "no label"))
     start
      ;  (perform (op trace-on))
       (perform (op initialize-stack))
       (perform (op print) (const "enter n:"))
       (assign n (op read))
      ;  (perform (op trace-off))
       (assign continue (label fact-done))   
     fact-loop
       (test (op =) (reg n) (const 1))
       (branch (label base-case))
       (save continue)                       
       (save n)                             
       (assign n (op -) (reg n) (const 1))   
       (assign continue (label after-fact))  
       (goto (label fact-loop))              
      after-fact                             
       (restore n)
       (restore continue)
       (assign val (op *) (reg n) (reg val)) 
       (goto (reg continue))                 
     base-case
       (assign val (const 1))               
       (goto (reg continue))                
      fact-done
       (perform (op print) (const "result: "))
       (perform (op print) (reg val))
       (perform (op print-stack-statistics))
       (perform (op print-instructions-statistics))
       (goto (label start))
       )))
(start test-machine)