(load "regsim.scm")
;the total number of push operations
;and the maximum stack depth
;used in computing n! for any n>1
;2n-2

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
(start test-machine)