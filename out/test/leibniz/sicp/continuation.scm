;;;continuation 和 call/cc 的基本概念：
;;;exp (+ (* 3 4) 5)
(define *k* #f)

(+ (* 3 4) 5)
; (lambda (v) v)
(call/cc (lambda (k)
           (k (+ (* 3 4) 5))))

(* 3 4)
; (lambda (v) (+ v 5))
(+ (call/cc (lambda (k)
              (k (* 3 4))))
   5)

3
; (lambda (v) (+ (* v 4) 5))
(+ (* (call/cc (lambda (k)
                 (set! *k* k)
                 (k 3)))
      4)
   5)

4
; (lambda (v) (+ (* 3 v) 5))
(+ (* 3
      (call/cc (lambda (k)
                 (k 4))))
   5)

5
;(lambda (v) (+ (* 3 4) v))
(+ (* 3 4)
   (call/cc (lambda (k)
              (k 5))))

*k*
(define x (*k* 5))


;;;一些例子
;;1.
(let ([x (call/cc (lambda (k) k))])
  (x (lambda (ignore) "hi")))

((lambda (x)
   (x (lambda (ignore) "hi")))
 (call/cc (lambda (k) k)))

;what is k?
(lambda (v)
  ((lambda (x)
     (x (lambda (ignore) "hi")))
   v))
(lambda (v)
  (let ((x v))
    (x (lambda (ignore "hi")))))

((lambda (x)
   (x (lambda (ignore) "hi")))
 (lambda (v)
   ((lambda (x)
      (x (lambda (ignore) "hi")))
    v)))

((lambda (v)
   ((lambda (x)
      (x (lambda (ignore) "hi")))
    v))
 (lambda (ignore) "hi"))

((lambda (x)
   (x (lambda (ignore) "hi")))
 (lambda (ignore) "hi"))

((lambda (ignore) "hi")
 (lambda (ignore) "hi"))

((lambda (ignore) "hi")
 (lambda (ignore) "hi"))

;;2.
(((call/cc (lambda (k) (set! *k* k) k))
  (lambda (x) x))
 "hey!")

;what is k?
(lambda (v)
  ((v (lambda (x) x))
   "hey!"))
(lambda (v)
  
  "hey!")


(((lambda (v)
  ((v (lambda (x) x)) "hey!"))
  (lambda (x) x))
 "hey!")

(((lambda (x) x)
  (lambda (x) x))"hey!")

((lambda (x) x)"hey!")

;;3.
(define product
  (lambda (ls)
    (call/cc
      (lambda (break)
        (let f ([ls ls])
          (cond
            [(null? ls) 1]
            [(= (car ls) 0) (break 0)]
            [else (* (car ls) (f (cdr ls)))]))))))

(define product
  (lambda (ls)
    (let f ([ls ls])
      (cond
        [(null? ls) 1]
        [(= (car ls) 0) 0]
        [else (* (car ls) (f (cdr ls)))]))))
;what is break?
(lambda (v)
  v)

(define product
  (lambda (ls)
    ((lambda (break)
        (let f ([ls ls])
          (cond
            [(null? ls) 1]
            [(= (car ls) 0) (break 0)]
            [else (* (car ls) (f (cdr ls)))])))
     (lambda (v) v))))

(define product
  (lambda (ls)
    (let f ([ls ls])
      (cond
        [(null? ls) 1]
        [(= (car ls) 0) ((lambda (v) v) 0)]
        [else (* (car ls) (f (cdr ls)))]))))

;what the difference?
(define product
  (lambda (ls)
    (let f ([ls ls])
      (cond
        [(null? ls) 1]
        [(= (car ls) 0) 0]
        [else (* (car ls) (f (cdr ls)))]))))

;4. ying yang puzzle
(let* ((yin
         ((lambda (cc) (display #\@) cc)
          (call/cc (lambda (c) c))))
       (yang
         ((lambda (cc) (display #\*) cc)
          (call/cc (lambda (c) c)))) )
    (yin yang))

(let ((yin
       ((lambda (cc) (display #\@) cc)
        (call/cc (lambda (c) c)))))
  (let ((yang
         ((lambda (cc) (display #\*) cc)
          (call/cc (lambda (c) c)))))
    (yin yang)))

((lambda (yin)
   ((lambda (yang)
      (yin yang))
    ((lambda (cc) (display #\*) cc)
     (call/cc (lambda (c) c)))))
 ((lambda (cc) (display #\@) cc)
  (call/cc (lambda (c) c))))

;5.
(define (disp x)
  (display x)
  "display return")

(disp (call/cc (lambda (k) 1)))

(<procedure>
 (call/cc (lambda (cont) <body>)))
;k : (lambda (v) (disp v))

;6.
(define retry #f)

(define factorial
  (lambda (x)
    (if (= x 0)
        (call/cc (lambda (k) (set! retry k) 2))
        (* x (factorial (- x 1))))))
;7.
(define lwp-list '())
(define lwp
  (lambda (thunk)
    (set! lwp-list (append lwp-list (list thunk)))))

(define start
  (lambda ()
    (let ([p (car lwp-list)])
      (set! lwp-list (cdr lwp-list))
      (p))))

(define pause
  (lambda ()
    (call/cc
      (lambda (k)
        (lwp (lambda () (k #f)))
        (start)))))

(lwp (lambda () (let f () (pause) (display "h") (f))))
(lwp (lambda () (let f () (pause) (display "e") (f))))
(lwp (lambda () (let f () (pause) (display "y") (f))))
(lwp (lambda () (let f () (pause) (display "!") (f))))
(lwp (lambda () (let f () (pause) (newline) (f))))
;;;cps
(define fact-cps
  (lambda (n k)
    (cond
      [(zero? n) (k 1)]
      [else (fact-cps (sub1 n)
                      (lambda (v)
                        (k (* v n))))])))
;think of v as (fact n)

(define fact
  (lambda (n)
    (fact-cps n (lambda (v) v))))

