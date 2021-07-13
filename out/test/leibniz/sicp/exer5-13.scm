; http://community.schemewiki.org/?sicp-ex-5.13
; meteorgan真是厉害，如果要我写的话，我会修改很多代码
(define (lookup-register name) 
      (let ((val (assoc name register-table))) 
       (if val 
           (cadr val) 
           (begin 
            (allocate-register name) 
            (lookup-register name)))))