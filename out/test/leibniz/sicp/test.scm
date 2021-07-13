(load "setup.scm")

(define exps
  (list
        ''(1 2 3 4 5)
        '(define x 1)
        '(set! x 2)
        '((lambda (x) (* x x)) x);4
        '(define (append x y)
           (if (null? x)
              y
              (cons (car x) (append (cdr x) y))))
        '(append '(a b c) '(d e f));(a b c d e f)
        '(if x 'ok 'fail)
        '(cond ((= x 2)
                'ok)
               (else 'fail))
        '(+ (* x x) (+ x 3)) ;9
        '(begin (+ 1 1) (+ 2 2)) ;4
        ))

; (map (lambda (exp) (eval exp the-global-environment)) exps)
(define (test-each exps)
  (if (null? exps)
      'done
      (begin
        (display
         (eval (car exps) the-global-environment))
        (newline)
        (test-each (cdr exps)))))

(test-each exps)