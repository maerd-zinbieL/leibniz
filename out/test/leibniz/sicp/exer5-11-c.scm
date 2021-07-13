(load "regsim.scm")

;;;需要修改的函数:
; make-new-machine
; make-save
; make-restore
; update-insts!
; make-execution-procedure
;因为变量命名问题需要修改后两个函数，主要修改前3个函数
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stacks-table (list )) ;修改
        (the-instruction-sequence '()))
    (let ((register-table
           ; pc需要关联一个栈吗
           (list (list 'pc pc) (list 'flag flag))))
      (let ((the-ops ;修改
             (list (list 'initialize-stack
                         (lambda ()
                             (let ((stacks (map cadr stacks-table)))
                               (for-each (lambda (stack)
                                           (stack 'initialize))
                                         stacks)))))))
        (define (allocate-register name);修改
          (if (assoc name register-table)
              (error "Multiply defined register: " name)
              (begin
                (set! register-table
                      (cons (list name (make-register name))
                            register-table))
                (set! stacks-table
                      (cons (list name (make-stack))
                            stacks-table))))
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
                ((eq? message 'stacks-table) stacks-table);修改
                ((eq? message 'operations) the-ops)
                (else (error "Unknown request -- MACHINE" message))))
        dispatch))))

(define (make-save inst machine stacks-table pc)
  (let ((reg-name (stack-inst-reg-name inst)))
    (let ((reg (get-register machine reg-name))
          (stack (cadr (assoc reg-name stacks-table))))
      (lambda ()
        (push stack (get-contents reg))
        (advance-pc pc)))))

(define (make-restore inst machine stacks-table pc)
   (let ((reg-name (stack-inst-reg-name inst)))
     (let ((reg (get-register machine reg-name))
           (stack (cadr (assoc reg-name stacks-table))))
       (lambda ()
         (set-contents! reg (pop stack))
         (advance-pc pc)))))

;在update-insts和make-execution-procedure里，将stack改成stacks-table
(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (stacks-table (machine 'stacks-table)) ;***
        (ops (machine 'operations)))
    (for-each
     (lambda (inst)
       (set-instruction-execution-proc! 
        inst
        (make-execution-procedure
         (instruction-text inst) labels machine
         pc flag stacks-table ops)))
     insts)))

(define (make-execution-procedure inst labels machine
                                  pc flag stacks-table ops)
  (cond ((eq? (car inst) 'assign)
         (make-assign inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'save)
         (make-save inst machine stacks-table pc))
        ((eq? (car inst) 'restore)
         (make-restore inst machine stacks-table pc))
        ((eq? (car inst) 'perform)
         (make-perform inst machine labels ops pc))
        (else (error "Unknown instruction type -- ASSEMBLE"
                     inst))))



;;;test
(define displayln (lambda (x) (display x) (newline)))
;;;为了方便查看stack的内容，修改make-stack函数（***部分）
(define (make-stack)
  (let ((s '()))
    (define (push x)
      (set! s (cons x s)))
    (define (pop)
      (if (null? s)
          (error "Empty stack -- POP")
          (let ((top (car s)))
            (set! s (cdr s))
            top)))
    (define (initialize)
      (set! s '())
      'done)
    (define (dispatch message)
      (cond ((eq? message 'push) push)
            ((eq? message 'pop) (pop))
            ((eq? message 'initialize) (initialize))
            ; 增加这一行以便，查看stack里的内容
            ((eq? message 'inspect) s);***
            (else (error "Unknown request -- STACK"
                         message))))
    dispatch))

;;;测试save
(define test-machine-0
  (make-machine
     '(a b)
     (list (list 'print displayln ))
     '(
       (assign a (const 1))
       (assign b (const 2))
       (save a)
       (save b)
       (assign a (const 3))
       (assign b (const 4))
       (save a)
       (save b)
       
       (perform (op print) (reg a))
       (perform (op print) (reg b))
     )
  ))

;;;测试restore
(define test-machine-1
  (make-machine
     '(a b)
     (list (list 'print displayln ))
     '(
       (assign a (const 1))
       (assign b (const 2))
       (save a)
       (save b)
       
       (assign a (const 3))
       (assign b (const 4))
       (perform (op print) (reg a))
       (perform (op print) (reg b))
       
       (restore a)
       (restore b)
       (perform (op print) (reg a))
       (perform (op print) (reg b))
     )
  ))

;;;测试initialize
(define test-machine-2
  (make-machine
     '(a b)
     (list (list 'print displayln ))
     '(
       (assign a (const 1))
       (assign b (const 2))
       (save a)
       (save b)
       
       (assign a (const 3))
       (assign b (const 4))
       (save a)
       (save b)

       (perform (op initialize-stack))
     )
  ))

(define (test machine)
  (start machine)
  (let ((stacks  (map cadr (machine 'stacks-table))))
    (displayln (map (lambda (stack) (stack 'inspect)) stacks)))
)

(test test-machine-0)
(test test-machine-1)
(test test-machine-2)
;3
; 4
; ((4 2) (3 1))
; 3
; 4
; 1
; 2
; (() ())
; (() ())