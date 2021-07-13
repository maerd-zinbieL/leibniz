;;;按照执行顺序，当运行到第一句(goto (label there))时，程序就会介绍。
;;;所以a的值应该是3
;;;测试
(define test-machine
  (make-machine
     '(a)
     (list )
     '(
       start
        (goto (label here))
       here
       (assign a (const 3))
       (goto (label there))
       here
       (assign a (const 4))
       (goto (label there))
       there
     )
  ))

(start test-machine) 
(get-register-contents test-machine 'a)


;;;修改
(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels (cdr text)
       (lambda (insts labels)
         (let ((next-inst (car text)))
           (if (symbol? next-inst)
               (if (assoc next-inst labels)
                ;  (memq next-inst (map car labels))
                   (error "Label already defined -- ASSEMBLE" next-inst)
                   (receive insts
                            (cons (make-label-entry next-inst
                                                    insts)
                                  labels)))
               (receive (cons (make-instruction next-inst)
                              insts)
                        labels)))))))
