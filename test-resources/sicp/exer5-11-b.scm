(load "regsim.scm")

; (define (make-save inst machine stack pc)
;   (let ((reg-name (stack-inst-reg-name inst)))
;     (let ((reg-value (get-contents
;                       (get-register machine reg-name))))
;       (lambda ()
;         (push stack (cons reg-name reg-value))
;         (advance-pc pc)))))

;上面的写法是错误的，因为reg-value永远是*unassigned*
(define (make-save inst machine stack pc)
  (let ((reg-name (stack-inst-reg-name inst)))
    (let ((reg (get-register machine reg-name)))
      (lambda ()
        (push stack (cons reg-name (get-contents reg)))
        (advance-pc pc)))))

(define (make-restore inst machine stack pc)
   (let ((reg-name (stack-inst-reg-name inst)))
     (let ((reg (get-register machine reg-name)))
       (lambda ()
         (let* ((poped (pop stack))
                (saved-name (car poped))
                (saved-value (cdr poped)))
         (if (equal? reg-name saved-name)
             (begin
               (set-contents! reg saved-value)
               (advance-pc pc)) 
             (error (string-append
                     "Can't restore the value into "
                     (symbol->string reg-name)
                    "which is saved by "
                    (symbol->string saved-name)
                    "-- ASSEMBLE ")
                    inst)))))))


;;;test
(define displayln (lambda (x) (display x) (newline)))

(define test-machine-0
  (make-machine
     '(a b)
     (list (list 'print displayln))
     '(
       (assign a (const 0))
       (assign b (const 1))
       (save a)
       (restore a)
       (save b)
       (restore b)
       (perform (op print) (reg a))
       (perform (op print) (reg b))
     )
  ))

(define test-machine-1
  (make-machine
     '(a b)
     (list (list 'print displayln))
     '(
       (assign a (const 0))
       (save a)
       (restore b)
     )
  ))

(start test-machine-0)
; (start test-machine-1)