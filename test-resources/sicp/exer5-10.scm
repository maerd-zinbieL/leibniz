;(jez <register> <label>)
;如果register里的值等于0就跳转到label
; (jgz <register> <label>)
;great than zero
; (jlz <register> <label>)
;less than zero

(define (judge-dest judge-inst)
  (caddr judge-inst))

(define (judge-register judge-inst)
  (cadr judge-inst))

(define (make-judge inst machine labels pc proc)
  (let ((dest (judge-dest inst))
        (reg (get-register machine (judge-register inst))))
    (if (label-exp? dest)
        (let ((insts (lookup-label labels (label-exp-label dest))))
          (lambda ()
            (if (proc (get-contents reg) 0)
                (set-contents! pc insts)
                (advance-pc pc))))
        (error "Bad judge instruction -- ASSEMBLE" inst))))

(define (make-jez inst machine labels pc)
  (make-judge inst machine labels pc =))

(define (make-jgz inst machine labels pc)
  (make-judge inst machine labels pc >))

(define (make-jlz inst machine labels pc)
  (make-judge inst machine labels pc <))

(define test-machine
  (make-machine
   '(a b c d)
   (list )
   '(
     (assign b (const 0))
     (assign c (const 0))
     (assign d (const 0))
     (jez a (label a=0))
     (jgz a (label a>0))
     (jlz a (label a<0))
     a=0
     (assign b (const 1))
     (goto (label done))
     a>0
     (assign c (const 1))
     (goto (label done))
     a<0
     (assign d (const 1))
     (goto (label done))
     done
   )
  ))

(define (test value)
  (set-register-contents! test-machine 'a value)
  (start test-machine)
  (map (lambda (reg)
                  (get-register-contents test-machine reg))
                '(b c d))
)
