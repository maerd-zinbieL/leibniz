
(load "../5-2/regsim.scm")
(define write-line write)
; (define (append x y)
;   (if (null? x)
;       y
;       (cons (car x) (append (cdr x) y))))

(define append-machine
  (make-machine
   '(x y temp res continue)
   (list (list 'cons cons)
         (list 'car car)
         (list 'cdr cdr)
         (list 'null? null?))
   '(
      (assign continue (label done))
    append-loop
      (test (op null?) (reg x))
      (branch (label base-case))
      (save continue)
      (assign continue (label after-append))
      (save x)
      (assign x (op cdr) (reg x))
      (goto (label append-loop))
    base-case
      (assign res (reg y))
      (goto (reg continue))
    after-append
      (restore x)
      (restore continue)
      (assign temp (op car) (reg x))
      (assign res (op cons) (reg temp) (reg res))
      (goto (reg continue))
    done)
  ))

(define (test-append x y)
  (set-register-contents! append-machine 'x x)
  (set-register-contents! append-machine 'y y)
  (start append-machine)
  (write-line
   (list 'x '= (get-register-contents append-machine 'x)
         'y '= (get-register-contents append-machine 'y)
         'result '= (get-register-contents append-machine 'res))))


; (define (append! x y)
;   (if (null? (cdr x))
;       (set-cdr! x y)
;       (append! (cdr x) y)))

(define append!-machine
  (make-machine
   '(x y res temp)
   (list (list 'set-cdr! set-cdr!)
         (list 'cdr cdr)
         (list 'null? null?))
   '(
      (assign res (reg x))
    append!-loop
      (assign temp (op cdr) (reg x))
      (test (op null?) (reg temp))
      (branch (label done))
      (assign x (op cdr) (reg x))
      (goto (label append!-loop))
    done
      (perform (op set-cdr!) (reg x) (reg y))
      (assign x (reg res)) ;保证寄存器x的值为append！后的值
   )))



(define (test-append! x y)
  (set-register-contents! append!-machine 'x x)
  (set-register-contents! append!-machine 'y y)
  (start append!-machine)
  (write-line
   (list 'x '= (get-register-contents append!-machine 'x)
         'y '= (get-register-contents append!-machine 'y)
         'result '= (get-register-contents append!-machine 'res))))