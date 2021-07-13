(load "regsim.scm")
; 将一条指令表示为：
; ((text label breakpoint?) .  procedure)
; breakpoint?: 0 => true, others => offset
(define (instruction-text inst)
  (caar inst))
(define (instruction-label inst)
  (cadar inst))
(define (instruction-bp inst)
  (caddar inst))

(define (find-label inst-text label labels)
  (if (null? labels)
      label
      (if (assoc inst-text (cdar labels))
          (find-label inst-text (caar labels) (cdr labels))
          (find-label inst-text label (cdr labels)))))

(define (assemble controller-text machine)
  (extract-labels controller-text
    (lambda (insts labels)
      (update-insts! insts labels machine)
      ((machine 'install-labels) labels) ;;;修改
      insts)))

(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (stack (machine 'stack))
        (ops (machine 'operations)))
    (define (update-label! inst)
      (let* ((text (car inst))
             (label (find-label text '() labels)))
        (set-car! inst (list text label 0)))) ;;;修改
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

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (the-instruction-labels '()))
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))
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
              (let ((inst (car insts)))
                (if (= 0 (instruction-bp inst))
                    (begin
                      ((instruction-execution-proc inst))
                      (execute))
                    (write-line
                     (list 'breakpoint '->
                           'label '= (instruction-label inst)
                           'offset '= (instruction-bp inst)
                           'text '= (instruction-text inst))))))))
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
              ((eq? message 'install-labels)
               (lambda (labels) (set! the-instruction-labels  labels)))
              ((eq? message 'labels)
               the-instruction-labels)
              ((eq? message 'proceed)
               (lambda ()
                 (let ((insts (get-contents pc)))
                   ((instruction-execution-proc (car insts)))
                   (execute))))
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (set-breakpoint machine label n)
  (let ((insts (lookup-label (machine 'labels) label)))
    (let ((inst (list-ref insts (- n 1))))
      (let ((text (instruction-text inst)))
        (set-car! inst (list text label n))))))    

(define (proceed-machine machine)
  ((machine 'proceed)))

(define (cancle-breakpoint machine label n)
  (let ((insts (lookup-label (machine 'labels) label)))
    (let ((inst (list-ref insts (- n 1))))
      (let ((text (instruction-text inst))
            (breakpoint? (instruction-bp inst)))
        (cond ((= 0 breakpoint?)
               (error "This is not a breakpoint
                      --CANCLE-BREAKPOINT" text))
              (else (set-car! inst (list text label 0))))))))

(define (cancle-all-breakpoint machine)
  (define (cancel-scan inst)
    (let ((text (instruction-text inst))
          (label (instruction-label inst))
          (breakpoint? (instruction-bp inst)))
      (cond ((= 0 breakpoint?)
             'pass)
            (else (set-car! inst (list text label 0))))))
  (let* ((labels (machine 'labels))
         (insts (cdar labels)))
    (for-each cancel-scan insts)
    'done))

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
       (perform (op print) (const "this instruction has no label"))
     start
       (perform (op initialize-stack))
       (perform (op print) (const "enter n:"))
       (assign n (op read))
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
       (goto (label start))
       )))
(set-breakpoint test-machine 'fact-done 3)
(set-breakpoint test-machine 'start 3)
; (cancle-all-breakpoint test-machine)
(start test-machine)