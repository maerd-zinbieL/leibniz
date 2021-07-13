#lang sicp

(#%require "../3-3/table.rkt")
(#%require "tree.rkt")
(#%require "interpreter.rkt")

(define (generate-by-streams root streams)
  "todo")

(define (generate-ins-tree s1 s2 root)
  (cond ((and (empty-stream? s1)
              (empty-stream? s2))
         (add-child! root (make-tree '())))
        ((and (empty-stream? s1)
              (not (empty-stream? s2)))
         (let ((child (make-tree (first-ins s2))))
           (add-child! root child)
           (generate-ins-tree s1 (rest-ins s2) child)))
        ((and (empty-stream? s2)
            (not (empty-stream? s1)))
         (let ((child (make-tree (first-ins s1))))
           (add-child! root child)
           (generate-ins-tree (rest-ins s1) s2 child)))
               
        (else (let ((child1 (make-tree (first-ins s1)))
                    (child2 (make-tree (first-ins s2))))
                (add-child! root child1)
                (generate-ins-tree (rest-ins s1) s2 child1)
                (add-child! root child2)
                (generate-ins-tree s1 (rest-ins s2) child2)))))

(define (all-paths tree)
  (let ((results (list )))
    (define (for-each-child proc l p)
      (if (null? (cdr l))
          (proc (car l) p)
          (begin
            (proc (car l) p)
            (for-each-child proc (cdr l) p))))
    (define (walk node path)
      (cond  ((= 0 (count-children node))
              (set! results (append results (list path))))
             (else (for-each-child walk
                                 (children node)
                                 (append path (list (datum node)))))))
    (walk tree '())
    results))

(define (solve all-paths)
  (define (iter path)
    (if (null? path)
        (begin
          (newline)
          (display (access-var 'x))
          (newline)
          (display "+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"))
        (begin
          (display (car path))
          (display "   ")
          ((car path))
          (iter (cdr path)))))
  (for-each iter all-paths))

;;;解决问题

(define regs1 (make-registers))
(define regs2 (make-registers))

(define a (lambda ()
            (reset-regs! regs1)
            (push-regs! regs1 'x)))
(define b (lambda ()
            (push-regs! regs1 'x)))
(define c (lambda ()
              (mutiply regs1)
              (pop-regs! regs1 'x)))

(define x (lambda ()
            (reset-regs! regs2)
            (push-regs! regs2 'x)))
(define y (lambda ()
            (push-regs! regs2 'x)))
(define z (lambda ()
            (push-regs! regs2 'x)))
(define u (lambda ()
              (mutiply regs2)
              (pop-regs! regs2 'x)))

(define s1 (make-instruction-stream a b c))
(define s2 (make-instruction-stream x y z u))

(define start
  (lambda ()
    (reset-memo!)
    (set-var! 'x 10)))

(define ins-tree (make-tree start))

(generate-ins-tree s1 s2 ins-tree)
(define paths (all-paths ins-tree))
(solve paths)

