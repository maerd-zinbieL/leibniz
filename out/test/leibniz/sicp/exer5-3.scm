; (controller
;   (assign guess (const 1.0))
;   good-enough?
;     (assign t0 (op *) (reg guess) (reg guess))
;     ;   能否在一步内对一个寄存器读取再赋值  
;     (assign t0 (op -) (reg t0) (reg x))
;     (test (op >) (reg t0) (const 0))
;     (branch (label less-than-0.001?))
;     (assign t0 (op -) (const 0) (reg t0))
;     less-than-0.001?
;       (test (op <) (reg t0) (const 0.001))
;       (branch (label done))
;   improve
;     (assign t0 (op /) (reg x) (reg guess))
;     (assign t0 (op +) (reg guess) (reg t0))
;     (assign guess (op /) (reg t0) (const 2))
;     (goto (label good-enough?))
;  done)
  
(define sqrt-machine
  (make-machine
   '(x guess t0)
   (list (list '- -)
         (list '< <)
         (list '/ /)
         (list '+ +)
         (list '* *)
         (list '> >))
     '((assign guess (const 1.0))
       good-enough?
       (assign t0 (op *) (reg guess) (reg guess))
       ;   能否在一步内对一个寄存器读取再赋值  
       (assign t0 (op -) (reg t0) (reg x))
       (test (op >) (reg t0) (const 0))
       (branch (label less-than-0.001?))
       (assign t0 (op -) (const 0) (reg t0))
       less-than-0.001?
       (test (op <) (reg t0) (const 0.001))
       (branch (label done))
       improve
       (assign t0 (op /) (reg x) (reg guess))
       (assign t0 (op +) (reg guess) (reg t0))
       (assign guess (op /) (reg t0) (const 2))
       (goto (label good-enough?))
       done)))

 (set-register-contents! sqrt-machine 'x 3) 
 (start sqrt-machine) 
  
 (get-register-contents sqrt-machine 'guess) 
   