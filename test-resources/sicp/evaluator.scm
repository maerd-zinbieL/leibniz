(load "table.scm")
(load "stream.scm")
(load "syntax.scm")
(load "frame.scm")

(load "data-base.scm")
(load "pattern-matching.scm")
(load "unification.scm")

(define (qeval query frame-stream)
  (let ((qproc (get (type query) 'qeval)))
    (if qproc
        (qproc (contents query) frame-stream)
        (simple-query query frame-stream))))

(define (simple-query query-pattern 
                      frame-stream)
  (stream-flatmap
   (lambda (frame)
     (stream-append-delayed
      (find-assertions query-pattern frame)
      (delay 
        (apply-rules query-pattern frame))))
   frame-stream))

(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
      frame-stream
      (conjoin (rest-conjuncts conjuncts)
               (qeval 
                (first-conjunct conjuncts)
                frame-stream))))

(put 'and 'qeval conjoin)

(define (disjoin disjuncts frame-stream)
  (if (empty-disjunction? disjuncts)
      the-empty-stream
      (interleave-delayed
       (qeval (first-disjunct disjuncts) 
              frame-stream)
       (delay (disjoin 
               (rest-disjuncts disjuncts)
               frame-stream)))))
(put 'or 'qeval disjoin)

(define (negate operands frame-stream)
  (stream-flatmap
   (lambda (frame)
     (if (stream-null? 
          (qeval (negated-query operands)
                 (singleton-stream frame)))
         (singleton-stream frame)
         the-empty-stream))
   frame-stream))
(put 'not 'qeval negate)

(define (lisp-value call frame-stream)
  (stream-flatmap
   (lambda (frame)
     (if (execute
          (instantiate
           call
           frame
           (lambda (v f)
             (error 
              "Unknown pat var: LISP-VALUE" 
              v))))
         (singleton-stream frame)
         the-empty-stream))
   frame-stream))
(put 'lisp-value 'qeval lisp-value)

(define (execute exp)
  (apply (eval (predicate exp) 
               user-initial-environment)
         (args exp)))

(define (always-true ignore frame-stream) 
  frame-stream)
(put 'always-true 'qeval always-true)
