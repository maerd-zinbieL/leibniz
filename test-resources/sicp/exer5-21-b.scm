(load "../5-2/regsim.scm")

(define count-leaves-b
  (make-machine
   '(n res tree continue)
   (list (list '+ +)
         (list 'car car)
         (list 'cdr cdr)
         (list 'null? null?)
         (list 'not-pair?
               (lambda (x)
                 (not (pair? x)))))
   '(
      (assign n (const 0))
      (assign continue (label done))
    count-loop 
      (test (op null?) (reg tree))
      (branch (label null-tree))
      (test (op not-pair?) (reg tree))
      (branch (label not-pair))
      (save continue)
      (assign continue (label after-car-tree))
      (save tree)
      (assign tree (op car) (reg tree))
      (goto (label count-loop))
    after-car-tree
      (assign n (reg res))
      (restore tree)
      (assign tree (op cdr) (reg tree))
      (restore continue)
      (save continue)
      (assign continue (label after-cdr-tree))
      (goto (label count-loop))
    after-cdr-tree
      (restore continue)
      (goto (reg continue))
    null-tree
      (assign res (reg n))
      (goto (reg continue))
    not-pair
      (assign res (op +) (reg n) (const 1))
      (goto (reg continue))   
    done)
       
  ))

; (set-register-contents! count-leaves-b
;                         'tree
;                         '(a (b c (d)) (e f) g))

; (start count-leaves-b)
; (write-line (get-register-contents count-leaves-b
;                                    'res))

(define (test tree)
  (set-register-contents! count-leaves-b
                        'tree
                        tree)
  
  (start count-leaves-b)
  (write-line (get-register-contents count-leaves-b
                                     'res))
  
  (load "exer5-21-a.scm")
  (set-register-contents! count-leaves-a
                        'tree
                        tree)

  (start count-leaves-a)
  (write-line (get-register-contents count-leaves-a
                                     'count)))
  