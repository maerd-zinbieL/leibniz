#lang sicp
(define (square n) (* n n))


(define (even? n)
  (= (remainder n 2) 0))


(define (has-nontrivial? n m)
  (if (or (= n 1) (= n (- m 1)))
      false
      (= (remainder (square n) m) 1)))


 (define (check x m)
     (if (has-nontrivial? x m)
         0
         (remainder (square x) m)))
;;;   (define (iter count a)
;;;     (cond ((= (- n 1) a) count)
;;;           ((= (remainder (square a) n) 1)
;;;            (display a)
;;;            (newline)
;;;            (iter (+ 1 count) (+ a 1)))
;;;           (else (iter count (+ a 1)))))
;;;   (iter 0 2))

           
;;; (define (expmod base_ori exp_ori m)
;;;         ;;; (cond ((= exp 0) 1)
;;;         ;;;   ((even? exp)
;;;         ;;;    (remainder
;;;         ;;;     (square (expmod base (/ exp 2) m))
;;;         ;;;     m))
;;;         ;;;   (else
;;;         ;;;    (remainder
;;;         ;;;     (* base (expmod base (- exp 1) m))
;;;         ;;;     m))))
;;;   (define (iter res base exp)
;;;     ;;; (display base)(display ",")(display exp)
;;;     ;;; (display ",")(display res) (newline)
;;;     (cond ((= exp 0) res)
;;;           ((has-nontrivial? base_ori exp_ori) 0)
;;;           ((even? exp)
;;;            (iter res
;;;                  (remainder (square base) m)
;;;                  (/ exp 2)))
;;;           (else (iter (remainder (* base res) m)
;;;                       base
;;;                       (- exp 1)))))
;;;   (iter 1 base_ori exp_ori))
 (define (expmod base exp m)
   (cond ((= exp 0) 1) 
         ((even? exp)
          (check (expmod base (/ exp 2) m) m)) 
         (else 
          (remainder (* base (expmod base (- exp 1) m)) 
                     m))))

(define (miller-rabin-test n)
  (define (iter a)
    ;;; (if (= a (- n 1))
    ;;;     (display true))
    (cond ((= a (- n 1)) true)
          ;;; ((= (expmod a (- n 1) n) 0) false)
          ((= (expmod a (- n 1) n) 1) (iter (+ a 1)))
          (else false)))
  (iter 2))
;;;   (define (iter a count)
;;;     (cond ((= a (- n 1)) count)
;;;           ((= (expmod a (- n 1) n) 1) (iter (+ a 1) count))
;;;           ((= (expmod a (- n 1) n) 0) (iter (+ a 1) (+ count 1)))))
;;;   (define (check count)
;;;     (if (= count 0)
;;;       true
;;;       count))
;;;   (check (iter 2 0)))
;;; (has-nontrivial? 15)
;;; (expmod 2 30 17)
;;; (has-nontrivial? 36)
(miller-rabin-test 561)
(miller-rabin-test 1105)
(miller-rabin-test 1729)
(miller-rabin-test 6601)
(miller-rabin-test 2821)