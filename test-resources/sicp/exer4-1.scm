(define (list-of-values-from-left exps env)
  (define (iter res exps)
    (if (no-operands? exps)
        res
        (iter (cons (eval (first-operand exps) env) res)
              (rest-operands exps))))
  (iter '() exps))


(define (list-of-values-from-right exps env)
  (if (no-operands? exps)
      '()
      (let ((rest-values
             (list-of-values-from-right (rest-operands exps) env)))
        (cons (eval (first-operand exps) env)
              rest-values))))


;;;test
(define (no-operands? exps)
  (null? exps))

(define (first-operand exps)
  (car exps))

(define (rest-operands exps)
  (cdr exps))

(define (eval exp env)
  (display exp))

(define exps '(1 2 3 4 5 6))

(newline)
(list-of-values-from-left exps 'env)
(newline)
(list-of-values-from-right exps 'env)
(newline)
