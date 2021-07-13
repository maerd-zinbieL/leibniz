#lang sicp

(#%require "../3-3/table.rkt")
(#%provide reset-memo!
           reset-regs!
           access-var
           set-var!
           make-registers
           push-regs!
           pop-regs!
           mutiply
           inspect-regs
           make-instruction-stream
           first-ins
           rest-ins
           empty-stream?
          ;  make-environment
          ;  env-regs
          ;  env-ins
           )
; (define (make-registers)
;   (let ((registers (make-table))
;         (reg-names '(r0 r1 r2 r3 r4 r5 r6 r7 r8 r9)))
;     (define (init!)
;       (define (iter names)
;         (if (not (null? names))
;             (begin
;               (insert! (car names) 0 registers)
;               (iter (cdr names)))))
;       (iter reg-names))
;     (define (get-reg reg-name)
;       (if (memq reg-name reg-names)
;           (lookup registers reg-name)
;           (error "register does not exist" "GET-REG")))
;     (define (set-reg! reg-name value)
;       (if (memq reg-name reg-names)
;           (insert! reg-name value registers)
;           (error "register does not exist" "SET-REG!")))
;     (define (dispatch m)
;       (cond ((eq? m 'get-reg)
;              get-reg)
;             ((eq? m 'set-reg!)
;              set-reg!)
;             ((eq? m 'reset-reg!)
;              init!)
;             (else (error "Unknown operation: 
;                           MAKE-REGISTER" m))))
;     (init!)
;     dispatch))

; (define regs (make-registers))
; (define (get-reg reg-name)
;   ((regs 'get-reg) reg-name))
; (define (set-reg! reg-name value)
;   ((regs 'set-reg!) reg-name value))
; (define (reset-reg!)
;   ((regs 'reset-reg!)))

; (define (make-instruction-stream)
;   (let ((stream (list )))
;     (define (add-ins! instruction)
;       (set! stream (append stream (list instruction))))
;     (define (first-ins)
;       (car stream))
;     (define (rest-ins)
;       (if (null? stream)
;           (begin
;             (set! stream (list ))
;             dispatch)
;           (begin
;             (set! stream (cdr stream))
;             dispatch)))
;     (define (empty-stream?)
;       (null? stream))
;     (define (dispatch m)
;       (cond ((eq? m 'add!) add-ins!)
;             ((eq? m 'first) first-ins)
;             ((eq? m 'rest) rest-ins)
;             ((eq? m 'empty?) empty-stream?)
;             (else (error "Unknown operation: 
;                           MAKE-INSTRUCTION-STREAM" m))))
;     dispatch))

; (define (add-ins! stream instruction)
;   ((stream 'add!) instruction))
; (define (first-ins stream)
;   ((stream 'first)))
; (define (rest-ins stream)
;   ((stream 'rest)))
; (define (empty-stream? stream)
;   ((stream 'empty?)))

(define (make-registers)
  (let ((regs (list )))
    (define (push-regs! x)
      (cond ((number? x)
             (set! regs (cons x regs)))
            ((symbol? x)
             (if (access-var x)
                 (set! regs (cons (access-var x) regs))
                 (error "Variable not defined:
                        PUSH-REGS!" x)))
            (else (error "Unknown symbol: 
                         PUSH-REGS!" x))))
     (define (mutiply)
        (set! regs (list (apply * regs))))
     (define (pop-regs! x)
       (cond ((not (symbol? x))
              (error "Not symbol:
                      POP-REGS!" x))
             ((not (access-var x))
              (error "Variable not defined:
                     POP-REGS!" x))
             ((null? regs)
              (error "Can not store anything:
                     POP-REGS!" x))
             (else
              (set-var! x (car regs))
              (set! regs (cdr regs)))))
     (define (dispatch m)
        (cond  ((eq? m 'mutiply) mutiply)
               ((eq? m 'push!) push-regs!)
               ((eq? m 'pop!) pop-regs!)
               ((eq? m 'reset!) (lambda ()
                                 (set! regs (list ))))
               ((eq? m 'regs) (lambda ()
                                (display regs)
                                (newline)))
               (else (error "Unknown operation: 
                            MAKE-REGISTERS" m))))
     dispatch))

(define (make-memory)
  (let ((ram (make-table)))
      (define (reset!)
        (set! ram (make-table)))
      (define (access-var var-name)
        (lookup ram var-name))
      (define (set-var! var-name value)
        (insert! var-name value ram))
      (define (dispatch m)
        (cond ((eq? m 'access-var) access-var)
              ((eq? m 'set-var!) set-var!)
              ((eq? m 'reset!) reset!)
              (else (error "Unknown operation: 
                         MAKE-RAM" m))))
      dispatch))

(define memo (make-memory))
(define (reset-memo!)
  (set! memo (make-memory)))
(define (access-var var-name)
  ((memo 'access-var) var-name))
(define (set-var! var-name value)
  ((memo 'set-var!) var-name value))

(define (push-regs! regs x)
  ((regs 'push!) x))
(define (pop-regs! regs x)
  ((regs 'pop!) x))
(define (mutiply regs)
  ((regs 'mutiply) ))
(define (inspect-regs regs)
  ((regs 'regs) ))
(define (reset-regs! regs)
  ((regs 'reset!) ))

(define (make-instruction-stream . ins)
  ins)
(define (first-ins stream)
  (car stream))
(define (rest-ins stream)
  (cdr stream))
(define (empty-stream? stream)
  (null? stream))

; (define (make-environment regs ins)
;   (cons regs ins))
; (define (env-regs env)
;   (car env))
; (define (env-ins env)
;   (cdr env))
