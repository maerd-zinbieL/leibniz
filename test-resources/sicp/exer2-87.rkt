#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-polynomial-package.rkt")

; (define (install-polynomial-package)
;   ...
;   (define (=zero-all-terms? L)
;     (cond ((empty-termlist? L) #t)
;           ((not (=zero? (coeff (first-term L)))) #f)
;           (else (=zero-all-terms? (rest-terms L)))))
;   ;; interface to rest of the system
;   ...
;   (put '=zero? '(polynomial)
;     (lambda (p)
;       (=zero-all-terms? (term-list p))))
;   ...
;   'done)

; (=zero? (make-polynomial 'x (list (list 3 (make-real 0))
;                                   (list 2 (make-rational 0 5))
;                                   (list 1 (make-scheme-number 0)))))
(define termlist (make-sparse-termlist
                          (list '(3 0) '(2 0) (list 1 (make-rational 0 3)))))
(=zero? (make-polynomial 'x termlist))
                         