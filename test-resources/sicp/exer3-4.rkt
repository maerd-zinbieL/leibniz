#lang sicp
(define (make-account balance passwd)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))))
  (let ((passwd-wrong-times 0))
    (define (dispatch-with-check p m)
      (define (call-the-cops)
        (begin (set! passwd-wrong-times 0)
          "calling the cops"))
      (if (eq? p passwd)
          (dispatch m)
          (lambda (x)
            (begin
            ;   (display passwd-wrong-times)
            ;   (newline)
              (set! passwd-wrong-times (+ passwd-wrong-times 1))
              (if (>= passwd-wrong-times 7)
                  (call-the-cops)
                  "Incorrect password")))))
    dispatch-with-check))
  
(define acc 
  (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
; ; 60

((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
; "Incorrect password"