(load "regsim.scm")

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

      (define (remove-duplicates-insts insts)
        (define (insert x seq)
          (cond ((null? seq)
                 (list x))
                ; ((equal? x (car seq))
                ;  seq)
                ((member x seq)
                 seq)
                ((eq? (car x) (caar seq))
                 (cons x seq))
                (else (cons (car seq)
                            (insert x (cdr seq))))))
        (if (null? insts)
            '()
            (let ((res (remove-duplicates-insts (cdr insts)))
                  (to-insert (car insts)))
              (insert to-insert res))))
      
      (define (get-insts-text)
         (map instruction-text the-instruction-sequence))
      
      (define (entry-registers insts)
          (if (null? insts)
              '()
              (let ((inst (car insts))
                    (res (entry-registers (cdr insts))))
                (if (and (eq? (car inst) 'goto)
                         (register-exp? (cadr inst))
                         (not (memq (cadadr inst) res)))
                    (cons (cadadr inst) res)
                    res))))
      
      (define (save-restore-regs insts)
          (if (null? insts)
              '()
              (let ((res (save-restore-regs (cdr insts)))
                    (inst (car insts)))
                (if (or (eq? (car inst) 'save)
                        (eq? (car inst) 'restore))
                    (if (memq (cadr inst) res)
                        res
                        (cons (cadr inst) res))
                    res))))

      (define (assign-source insts)
        (let ((reg-src-table
               (map (lambda (reg)
                      (list (car reg) '())) register-table)))
          (define (scan insts)
            (if (null? insts)
                reg-src-table
                (let ((inst (car insts)))
                  (if (eq? (car inst) 'assign)
                      (let* ((reg-name (cadr inst))
                             (reg-srcs (assoc reg-name reg-src-table))
                             (sources (cadr reg-srcs))
                             ;(assign val (const 1)): source is (const 1), caddr
                             ;(assign val (op +) (reg n) (reg val)):
                           ; source is ((op +) (reg n) (reg val)), cddr
                             (source (if (= (length (cddr inst))
                                            1)
                                       (caddr inst)
                                       (cddr inst))))
                        (if (memq source sources)
                            (scan (cdr insts))
                            (begin
                              (set-cdr! reg-srcs (cons source (list sources)))
                              (scan (cdr insts)))))
                      (scan (cdr insts))))))
          (scan insts)))
                          
      
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
              ((eq? message 'instructions)
                (remove-duplicates-insts (get-insts-text)))
              ((eq? message 'entries)
               (entry-registers
                 (get-insts-text)))
              ((eq? message 'save-restore)
               (save-restore-regs
                (get-insts-text)))
              ((eq? message 'assign-source)
               (assign-source
                (get-insts-text)))
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))


;;;test
(define test-machine
  (make-machine
     '(continue n val)
     (list (list '< <)
           (list '+ +)
           (list '- -))
     '(
       (assign continue (label fib-done))
       fib-loop
       (test (op <) (reg n) (const 2))
       (branch (label immediate-answer))
       ;; set up to compute Fib(n − 1)
       (save continue)
       (assign continue (label afterfib-n-1))
       (save n)           ; save old value of n
       (assign n 
               (op -)
               (reg n)
               (const 1)) ; clobber n to n-1
       (goto 
        (label fib-loop)) ; perform recursive call
       afterfib-n-1 ; upon return, val contains Fib(n − 1)
       (restore n)
       (restore continue)
       ;; set up to compute Fib(n − 2)
       (assign n (op -) (reg n) (const 2))
       (save continue)
       (assign continue (label afterfib-n-2))
       (save val)         ; save Fib(n − 1)
       (goto (label fib-loop))
       afterfib-n-2 ; upon return, val contains Fib(n − 2)
       (assign n 
               (reg val)) ; n now contains Fib(n − 2)
       (restore val)      ; val now contains Fib(n − 1)
       (restore continue)
       (assign val        ; Fib(n − 1) + Fib(n − 2)
               (op +) 
               (reg val)
            (reg n))
       (goto              ; return to caller,
        (reg continue))   ; answer is in val
       immediate-answer
       (assign val 
            (reg n))   ; base case: Fib(n) = n
       (goto (reg continue))
    ;    (goto (reg n));for testing entry rigisters
       fib-done
    )
     ))
  
  (define (test)
;   (set-register-contents! test-machine 'n 10)
;   (start test-machine)
;   (get-register-contents test-machine 'val);55
   (let ((insts (test-machine 'instructions)))
     (for-each write-line insts)
     (write-line (length insts)))
   (newline)
   
   (write-line (test-machine 'entries))
   (newline)
   
   (write-line (test-machine 'save-restore))
   (newline)
   
   (write-line (test-machine 'assign-source))
;   ((val (reg n)
;         ((op +) (reg val) (reg n)))
;    (n   (reg val)
;         ((op -) (reg n) (const 2)))
;    (continue (label afterfib-n-2)
;              (label afterfib-n-1))
;    (pc ())
;    (flag ()))
  )

(test)