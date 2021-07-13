#lang sicp

(define (make-mobile left right)
  (list left right))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (make-branch length structure)
  (list length structure))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (not (pair? structure))
        structure
        (let ((left (left-branch structure))
              (right (right-branch structure)))
          (+ (branch-weight left)
             (branch-weight right))))))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (balance? mobile)
  (if (pair? mobile)
      (let ((lb (left-branch mobile))
            (rb (right-branch mobile)))
        (and (= (* (branch-weight lb) (branch-length lb))
                (* (branch-weight rb) (branch-length rb)))
             (balance? (branch-structure lb))
             (balance? (branch-structure rb))))
      true))

; Test
(define a (make-mobile (make-branch 2 3) (make-branch 2 3))) 

(define d (make-mobile (make-branch 10 a) (make-branch 12 5))) 
(define m1 (make-mobile 
             (make-branch 4 6) 
             (make-branch 5 
                          (make-mobile 
                           (make-branch 3 7) 
                           (make-branch 9 8)))))
(define m2 (make-mobile 
             (make-branch 4 6) 
             (make-branch 2 
                          (make-mobile 
                           (make-branch 5 8) 
                           (make-branch 10 4)))))
(total-weight m1)  ;;21
(total-weight a) ;; 6
(total-weight d) ;; 11
(balance? a) ;;#t
(balance? d) ;;#t
(balance? m2) ;;#t 
(balance? m1);; #f 