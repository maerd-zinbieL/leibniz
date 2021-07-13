#lang sicp

(#%require "type.rkt")
(#%require "table.rkt")
(#%require "variable.rkt")
(#%require "generic.rkt")
(#%require "install-polynomial-term-package.rkt")

(define (install-sparse-package)
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  (define (the-empty-termlist) '())
  (define (first-term term-list)
    (if (empty-termlist? term-list)
        false
        (car term-list)))
  (define (rest-terms term-list)
    (if (empty-termlist? term-list)
        false
        (cdr term-list)))
  (define (negative-termlist L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (adjoin-term
         (make-term (order (first-term L))
                    (negative (coeff (first-term L))))
         (negative-termlist (rest-terms L)))))
  (define (empty-termlist? term-list) 
    (null? term-list))
  (define (make-termlist terms)
    terms)

  (define (tag p) (attach-tag 'sparse p))
  (put 'adjoin-term 'sparse
       (lambda (term termlist) (tag (adjoin-term term termlist))))
  (put 'the-empty-termlist 'sparse (tag (the-empty-termlist)))
    (put 'negative-termlist '(sparse)
       (lambda (termlist)
         (tag (negative-termlist termlist))))
  (put 'first-term '(sparse) first-term)
  (put 'rest-terms '(sparse)
       (lambda (term-list)
         (tag (rest-terms term-list))))
  (put 'empty-termlist? '(sparse) empty-termlist?)
  (put 'make-termlist 'sparse
       (lambda (terms)
         (tag (make-termlist terms))))
  'done)

(install-sparse-package)