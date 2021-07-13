;;;记得在eceval-comoiler注册lexical-address-lookup lexical-address-set!
;;;一开始的思路，如果find-variable返回not-found，就执行
; (perform (op lexical-address-set!) (const ,lexical-addr)(reg val) (op get-global-environment))
; 然后发现(op get-global-environment)不能这么用。
; (define (compile-assignment exp target linkage compile-env)
;   (let ((var (assignment-variable exp))
;         (get-value-code
;          (compile (assignment-value exp) 'val 'next compile-env)))
;     (let ((lexical-addr (find-variable var compile-env)))
;       (let ((lookup-env (if (eq? lexical-addr 'not-found)
;                             '(op get-global-environment)
;                             '(reg env))))
;         (end-with-linkage linkage
;           (preserving '(env)
;             get-value-code
;             (make-instruction-sequence '(env val) (list target)
;                 `((perform (op lexical-address-set!)
;                            (const ,lexical-addr)
;                            (reg val)
;                            ,lookup-env)
;                   (assign ,target (const ok))))))))))

; (define (compile-variable exp target linkage compile-env)
;   (let ((lexical-addr (find-variable exp compile-env)))
;     (let ((lookup-env (if (eq? 'not-found lexical-addr)
;                           '(op get-global-environment)
;                           '(reg env))))
;       (end-with-linkage linkage
;         (make-instruction-sequence '(env) (list target)
;           `((assign ,target
;                     (op lexical-address-lookup)
;                     (const ,lexical-addr)
;                     ,lookup-env)))))))

(define (compile-variable exp target linkage compile-env)
  (let ((lexical-addr (find-variable exp compile-env)))
    (let ((instructions
           (if (eq? 'not-found lexical-addr)
               (make-instruction-sequence
                  '() `(env ,target)
                  `((assign env (op get-global-environment))
                    (assign ,target
                            (op lookup-variable-value)
                            (const ,exp)
                            (reg env))))
               (make-instruction-sequence
                  '(env) `(,target)
                  `((assign ,target
                            (op lexical-address-lookup)
                            (const ,lexical-addr)
                            (reg env)))))))
      (end-with-linkage linkage instructions))))

(define (compile-assignment exp target linkage compile-env)
  (let ((var (assignment-variable exp))
        (get-value-code
         (compile (assignment-value exp) 'val 'next compile-env)))
    (let ((lexical-addr (find-variable var compile-env)))
      (let ((instructions
             (if (eq? 'not-found lexical-addr)
                 (make-instruction-sequence
                    '(val env) `(env ,target)
                    `((assign env (op get-global-environment))
                      (perform (op set-variable-value!)
                               (const ,var)
                               (reg val)
                               (reg env))
                      (assign ,target (const ok))))
                 (make-instruction-sequence
                    '(env val) `(,target)
                    `((perform (op lexical-address-set!)
                               (const ,lexical-addr)
                               (reg val)
                               (reg env))
                      (assign ,target (const ok)))))))
        (end-with-linkage linkage
          (preserving '(env) get-value-code instructions))))))