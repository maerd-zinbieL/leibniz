;   (assign continue (label expt-done))
; expt-loop
;   (test (op =) (reg n) (const 0))
;   (branch (label base-case))
;   (save continue)
;   (assign n (op -) (reg n) (const 1))
;   (assign continue (label after-expt))
;   (goto (label expt-loop))
; after-expt
;   (restore continue)
;   (assign val (op *) (reg n) (reg b))
;   (goto (reg continue))
; base-case
;   (assign val (const 1))
;   (goto (reg continue))
; expt-done

;   (assign product (const 1))
; expt-loop
;   (test (op =) (reg counter) (const 0))
;   (branch (label expt-done))
;   (assign counter (op -) (reg counter) (const 1))
;   (assign product (op *) (reg product) (reg b))
;   (goto (label expt-loop))
; expt-done

(define expt-rec-machine
  (make-machine
   '(b n val continue)
   (list (list '= =)
         (list '- -)
         (list '* *)
         )
     '(
        (assign continue (label expt-done))
      expt-loop
        (test (op =) (reg n) (const 0))
        (branch (label base-case))
        (save continue)
        (assign n (op -) (reg n) (const 1))
        (assign continue (label after-expt))
        (goto (label expt-loop))
      after-expt
        (restore continue)
        (assign val (op *) (reg b) (reg val))
        (goto (reg continue))
      base-case
        (assign val (const 1))
        (goto (reg continue))
      expt-done
        )
  ))

(define (expt-rec b n)
  (set-register-contents! expt-rec-machine 'b b)
  (set-register-contents! expt-rec-machine 'n n) 
  (start expt-rec-machine) 
  (get-register-contents expt-rec-machine 'val)
)

(define expt-iter-machine
  (make-machine
     '(counter product b)
     (list (list '- -)
           (list '* *)
           (list '= =))
     '(
         (assign product (const 1))
       expt-loop
         (test (op =) (reg counter) (const 0))
         (branch (label expt-done))
         (assign counter (op -) (reg counter) (const 1))
         (assign product (op *) (reg product) (reg b))
         (goto (label expt-loop))
       expt-done
     )
  ))

(define (expt-iter b n)
  (set-register-contents! expt-iter-machine 'b b)
  (set-register-contents! expt-iter-machine 'counter n) 
  (start expt-iter-machine) 
  (get-register-contents expt-iter-machine 'product)
)