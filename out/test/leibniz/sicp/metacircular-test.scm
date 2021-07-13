(load "setup.scm")

(define (make-chcker expr res)
  (cons expr res))
(define (chcker-exprs chcker) (car chcker))
(define (chcker-res chcker) (cdr chcker))
(define (add-test! expr res chcker)
  (set-car! chcker
            (append (chcker-exprs chcker) (list expr)))
  (set-cdr! chcker
            (append (chcker-res chcker) (list res))))
(define (chcke chcker)
  (let ((exprs (chcker-exprs chcker))
        (expects (chcker-res chcker)))
    (define (test-each exprs expects)
      (if (null? exprs)
          "all passed"
          (let ((expr (car exprs))
                (expct (car expects)))
            (display expr)
            (display " => ")
            (let ((eval-res (eval_ expr the-global-environment)))
              (if (equal? eval-res expct)
                  (begin
                    (display "pass\n")
                    (test-each (cdr exprs) (cdr expects)))
                  (begin
                    (display "fail\n")
                    "fail"))))))
    (test-each exprs expects)))

(define exprs
  (list
        'true                                        ;t
        'false                                       ;f
        ''(1 2 3 4 5)                                ;(1 2 3 4 5)
        '(define x 1)                                ;#definition
        '(set! x 2)                                  ;#assignment
        '((lambda (x) (* x x)) x)                    ;4
        '(define (append x y)
           (if (null? x)
              y
              (cons (car x) (append (cdr x) y))))    ;#definition
        '(append '(a b c) '(d e f))                  ;(a b c d e f)
        '(if x 'ok 'fail)
        '(if #t #t #f)                               ;t
        '(cond ((= x 2)
                'ok)
               (else 'fail))                         ;ok
        '(+ (* x x) (+ x 3))                         ;9
        '(begin (+ 1 1) (+ 2 2))                     ;4
        '(and true true false)                       ;#f
        '(and true true true)                        ;#t
        '(and (define a 1) (define b 2))             ;#definition
        '(and (define a 1) false (define b 2))       ;#f
        '(and )                                      ;#t
        '(or false true false)                       ;#t
        '(or false false false)                      ;#f
        '(or (define a 1) (define b 2))              ;#t
        '(or )                                       ;#f
        '(cond ((cdr (cons 'a x))
                => (lambda (x) x))
               (else false))                         ;2
        '(let ((x 4) (y 3))
           (let ((z 5))
             (* x y z)(+ x y z)))                    ;12
        '(let* ((x 3)
                (y (+ x 2))
                (z (+ x y 5)))
           (+ x y)(* x z))                           ;39
        '(let fib-iter ((a 1) (b 0) (count 10))
           (if (= count 0)
               b
               (fib-iter (+ a b) 
                     a 
                     (- count 1))))                 ;55
        '(define i 0)                               ;#definition
        '(while (< i 10)
            (display i) (set! i (+ i 1)))           ;0123456789#while
        '(let () (* x x))                            
        ))

(define res
  (list
        #t
        #f
        '(1 2 3 4 5)
        "#definition"
        "#assignment"
        4
        "#definition"
        '(a b c d e f)
        'ok
        #t
        'ok
        9
        4
        #f
        #t
        "#definition"
        #f
        #t
        #t
        #f
        #t
        #f
        2
        12
        39
        55
        "#definition"
        "#while"
        4
        ))


(define the-chcker (make-chcker exprs res))
(add-test! '(define t 1) "#definition" the-chcker)
(add-test! '(undef t) "#undefine" the-chcker)
(newline)
(chcke the-chcker)
; (newline)

; (define exprs
;   (list
;         'true                                        ;t
;         'false                                       ;f
;         ''(1 2 3 4 5)                                ;(1 2 3 4 5)
;         '(define x 1)                                ;#definition
;         '(set! x 2)                                  ;#assignment
;         '((lambda (x) (* x x)) x)                    ;4
;         '(define (append x y)
;            (if (null? x)
;               y
;               (cons (car x) (append (cdr x) y))))    ;#definition
;         '(append '(a b c) '(d e f))                  ;(a b c d e f)
;         '(if x 'ok 'fail)
;         '(if #t #t #f)                               ;t
;         '(cond ((= x 2)
;                 'ok)
;                (else 'fail))                         ;ok
;         '(+ (* x x) (+ x 3))                         ;9
;         '(begin (+ 1 1) (+ 2 2))                     ;4
;         '(and true true false)                       ;#f
;         '(and true true true)                        ;#t
;         '(and (define a 1) (define b 2))             ;#definition
;         '(and (define a 1) false (define b 2))       ;#f
;         '(and )                                      ;#t
;         '(or false true false)                       ;#t
;         '(or false false false)                      ;#f
;         '(or (define a 1) (define b 2))              ;#t
;         '(or )                                       ;#f
;         '(cond ((cdr (cons 'a x))
;                 => (lambda (x) x))
;                (else false))                         ;2
;         '(let ((x 4) (y 3))
;            (let ((z 5))
;              (* x y z)(+ x y z)))                    ;12
;         '(let* ((x 3)
;                 (y (+ x 2))
;                 (z (+ x y 5)))
;            (+ x y)(* x z))                           ;39
;         '(let fib-iter ((a 1) (b 0) (count 10))
;            (if (= count 0)
;                b
;                (fib-iter (+ a b) 
;                      a 
;                      (- count 1))))                 ;55
;         '(define i 0)                               ;#definition
;         '(while (< i 10)
;             (display i) (set! i (+ i 1)))           ;0123456789#while
;         '(define t 1)
;         '(undef t)
;         't
;   ))

; (define (test-each exprs)
;   (if (null? exprs)
;       'done
;       (begin
;         (display
;          (eval_ (car exprs) the-global-environment))
;         (newline)
;         (test-each (cdr exprs)))))

; (test-each exprs)