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
  (define (dispatch-with-check p m)
    (if (eq? p passwd)
        (dispatch m)
        (lambda (x) "Incorrect password")))
  dispatch-with-check)

(define acc 
  (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
; ; 60

((acc 'some-other-password 'deposit) 50)
; "Incorrect password"