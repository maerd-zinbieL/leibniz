(load "evaluator.scm")
(define input-prompt  ";;; Query input:")
(define output-prompt ";;; Query results:")

(define (prompt-for-input string)
  (newline)
  (newline)
  (display string)
  (newline))

(define (query-driver-loop)
  (prompt-for-input input-prompt)
  (let ((q (query-syntax-process (read))))
    (cond ((assertion-to-be-added? q)
           (add-rule-or-assertion! 
            (add-assertion-body q))
           (newline)
           (display 
            "Assertion added to data base.")
           (query-driver-loop))
          (else
           (newline)
           (display output-prompt)
           (display-stream
            (stream-map
             (lambda (frame)
               (instantiate
                q
                frame
                (lambda (v f)
                  (contract-question-mark v))))
             (qeval q (singleton-stream '()))))
           (query-driver-loop)))))

(define (instantiate 
         exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
           (let ((binding 
                  (binding-in-frame 
                   exp frame)))
             (if binding
                 (copy 
                  (binding-value binding))
                 (unbound-var-handler 
                  exp frame))))
          ((pair? exp)
           (cons (copy (car exp)) 
                 (copy (cdr exp))))
          (else exp)))
  (copy exp))

(query-driver-loop)