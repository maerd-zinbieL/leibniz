(load "../5-2/regsim.scm")

(define count-leaves-a
  (make-machine
   '(count temp tree continue)
   (list (list '+ +)
         (list 'car car)
         (list 'cdr cdr)
         (list 'null? null?)
         (list 'not-pair?
               (lambda (x)
                 (not (pair? x)))))
   '(
       (assign count (const 0))
       (assign continue (label done))
     count-loop
       (test (op null?) (reg tree))
       (branch (label null))
       (test (op not-pair?) (reg tree))
       (branch (label not-pair))
       (save continue)
       (assign continue (label after-car-tree)) 
       (save tree)
       (assign tree (op car) (reg tree))
       (goto (label count-loop))
     after-car-tree
       (restore tree)
       (restore continue)
       (assign tree (op cdr) (reg tree))
       (save continue)
       (assign continue (label after-cdr-tree))
       (save count)
       (goto (label count-loop))
     after-cdr-tree
       (assign temp (reg count))
       (restore count)
       (restore continue)
       (assign count
               (op +)
               (reg count)
               (reg temp))
       (goto (reg continue))
     null
       (assign count (const 0))
       (goto (reg continue))
     not-pair
       (assign count (const 1))
       (goto (reg continue))
     done)
  ))

; (set-register-contents! count-leaves-a
;                         'tree
;                         '(1 (3 4) 5 (6 (7 8 3) 9)))

; (start count-leaves-a)
; (write-line (get-register-contents count-leaves-a
;                                    'count))