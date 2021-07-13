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

(define (make-joint acc acc-pw new-pw)
  (lambda (p m)
    (if (eq? p new-pw)
        (acc acc-pw m)
        (lambda (x) "Incorrect password"))))

(define peter-acc
  (make-account 100 'open-sesame))


(define paul-acc
  (make-joint peter-acc 
              'open-sesame 
              'rosebud))

((peter-acc 'open-sesame 'withdraw) 30)

((paul-acc 'rosebud 'withdraw) 50)

((peter-acc 'open-sesame 'withdraw) 10)

((paul-acc 'rosebud 'deposit) 50)

((peter-acc 'open-sesame 'withdraw) 10)
