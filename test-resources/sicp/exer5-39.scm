
;;;lexical-addr : (cons frame-index var-index)
;;;下面代码应加入eceval-support.scm。
(define (lexical-address-lookup lexical-addr env)
  (define (scan var-index vars vals)
    (cond ((null? vals)
           (error "Unbound variable --Lexical-Adress-Lookup"))
          ((= 0 var-index)
           (let ((find (car vals)))
             (if (eq? find '*unassigned*)
                 (error "Variable *Unassigned*: " (car vars))
                 find)))
          (else (scan (- var-index 1) (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
      (error "Unbound variable --Lexical-Adress-Lookup")
      (let ((frame-index (car lexical-addr))
            (var-index (cdr lexical-addr)))
        (if (= 0 frame-index)
            (let ((frame (first-frame env)))
              (scan var-index
                    (frame-variables frame)
                    (frame-values frame)))
            (let ((next-lexical-addr
                   (cons (- frame-index 1) var-index)))
              (lexical-address-lookup
               next-lexical-addr
               (enclosing-environment env)))))))
  
(define (lexical-address-set! lexical-addr val env)
  (define (scan! var-index vals)
    (cond ((null? vals)
           (error "Unbound variable --Lexical-Adress-Set!"))
          ((= 0 var-index)
           (set-car! vals val))
          (else (scan! (- var-index 1)  (cdr vals)))))
   (if (eq? env the-empty-environment)
       (error "Unbound variable --Lexical-Adress-Set!")
       (let ((frame-index (car lexical-addr))
             (var-index (cdr lexical-addr)))
         (if (= 0 frame-index)
             (let ((frame (first-frame env)))
               (scan! var-index (frame-values frame)))
             (let ((next-lexical-addr
                    (cons (- frame-index 1) var-index)))
               (lexical-address-lookup
                next-lexical-addr
                (enclosing-environment env)))))))