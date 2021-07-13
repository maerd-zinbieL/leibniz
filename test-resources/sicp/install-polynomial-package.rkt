#lang sicp


(#%require "type.rkt")
(#%require "table.rkt")
(#%require "variable.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-polynomial-term-package.rkt")
(#%require "install-polynomial-dense-package.rkt")
(#%require "install-polynomial-sparse-package.rkt")

(#%provide make-term
           order
           coeff
           first-term
           rest-terms
           adjoin-term
           empty-termlist?
           the-empty-termlist 
           make-dense-termlist
           make-sparse-termlist
           make-polynomial)

(define (adjoin-term term term-list)  
  ((get 'adjoin-term (type-tag term-list))
   term (contents term-list)))
(define (first-term term-list)
  (apply-generic 'first-term term-list)) 
(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))
(define (empty-termlist? termlist)
  (apply-generic 'empty-termlist? termlist))
(define (the-empty-termlist L) ;;;一个棘手的问题
  ((get 'make-termlist (type-tag L)) '()))
(define (negative-termlist term-list)
  (apply-generic 'negative-termlist term-list))
(define (make-dense-termlist coeffs)
  ((get 'make-termlist 'dense) coeffs))
(define (make-sparse-termlist terms)
  ((get 'make-termlist 'sparse) terms))

; (define L1 (make-dense-termlist '(0 0 0 )))
; (define L2 (make-dense-termlist '(0 0 1 0 0 -1)))
; (display L1)
; (newline)
; (display L2)
; (newline)
; (first-term L1)
; (first-term L2)
; (rest-terms L1)
; (rest-terms L2)
; (first-term (rest-terms L1))
; (first-term (rest-terms L2))
; (adjoin-term (make-term 7 1) L1)
; (adjoin-term (make-term 5 1) L2)
; (negative-termlist L2)
; (empty-termlist? L1)

(define (install-polynomial-package)
  ;; internal procedures
  
  ;; representation of poly
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  
  ;; representation of terms and term lists
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1)) 
                 (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term
                     t1 
                     (add-terms (rest-terms L1) 
                      L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term
                     t2 
                     (add-terms 
                      L1 
                      (rest-terms L2))))
                   (else
                    (adjoin-term
                     (make-term 
                      (order t1)
                      (add (coeff t1) 
                           (coeff t2)))
                     (add-terms 
                      (rest-terms L1)
                      (rest-terms L2)))))))))
  (define (sub-terms L1 L2)
    (add-terms L1 (negative-termlist L2)))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist L1)
        (add-terms 
                   (mul-term-by-all-terms 
                    (first-term L1) L2)
       (mul-terms (rest-terms L1) L2))))
  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist L)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term 
            (+ (order t1) (order t2))
            (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms 
            t1 
            (rest-terms L))))))
  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
        (list (the-empty-termlist L1) 
              (the-empty-termlist L1))
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
          (if (> (order t2) (order t1))
              (list (the-empty-termlist L1) L1)
              (let ((new-c (div (coeff t1) 
                                (coeff t2)))
                    (new-o (- (order t1) 
                              (order t2))))
                (let ((rest-of-result
                       (div-terms
                        (sub-terms
                         L1
                         (mul-term-by-all-terms
                          (make-term new-o new-c)
                          L2))
                        L2)))
                  (list (adjoin-term (make-term new-o new-c )
                                     (car rest-of-result))
                        (cadr rest-of-result))))))))
  
  ; (define (test-term-func)
  ;   (let (
  ;         (L1 (make-sparse-termlist '((5 1) (0 -1))))
  ;         (L2 (make-sparse-termlist '((2 1) (0 -1))))
  ;         (L1 (make-dense-termlist '(1 0 0 0 0 -1)))
  ;         (L2 (make-dense-termlist '(1 0 -1)))
  ;         )
  ;     (display L1)
  ;     (newline)
  ;     (display L2)
  ;     (newline)
      
  ;     (display "div:")
  ;     (display (div-terms L1 L2))
  ;     (newline)
  ;     (display "add:")
  ;     (display (add-terms L1 L2))
  ;     (newline)
  ;     (display "sub:")
  ;     (display (sub-terms L1 L2))
  ;     (newline)
  ;     (display "mul:")
  ;     (display (mul-terms L1 L2))
  ;     (newline)))
  ; (test-term-func)
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) 
                        (variable p2))
        (make-poly 
         (variable p1)
         (add-terms (term-list p1)
                    (term-list p2)))
        (error "Polys not in same var: 
               ADD-POLY"
               (list p1 p2))))
  (define (sub-poly p1 p2)
    (if (same-variable? (variable p1) 
                        (variable p2))
        (make-poly 
         (variable p1)
         (sub-terms (term-list p1)
                    (term-list p2)))
        (error "Polys not in same var: 
               SUB-POLY"
               (list p1 p2))))
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) 
                        (variable p2))
      (make-poly 
       (variable p1)
       (mul-terms (term-list p1)
                  (term-list p2)))
      (error "Polys not in same var: 
             MUL-POLY"
             (list p1 p2))))
   (define (div-poly p1 p2)
     (if (same-variable? (variable p1) 
                         (variable p2))
         (let ((result (div-terms (term-list p1)
                                  (term-list p2))))
           (list (make-poly (variable p1) (car result))
            (make-poly (variable p1) (cdr result))))
         (error "Polys not in same var: 
                DIV-POLY"
                (list p1 p2))))
  (define (=zero-all-terms? L)
    (cond ((empty-termlist? L) #t)
          ((not (=zero? (coeff (first-term L)))) #f)
          (else (=zero-all-terms? (rest-terms L)))))
                      
  ;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) 
         (tag (add-poly p1 p2))))
  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2)
         (tag (sub-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) 
         (tag (mul-poly p1 p2))))
  (put 'div '(polynomial polynomial) 
       (lambda (p1 p2)
        (div-poly p1 p2)))
  (put 'negative '(polynomial)
       (lambda (p)
         (tag (make-poly
               (variable p)
               (negative-termlist (term-list p))))))
  (put '=zero? '(polynomial)
    (lambda (p)
      (=zero-all-terms? (term-list p))))
  (put 'make 'polynomial
       (lambda (var terms) 
         (tag (make-poly var terms))))
  'done)

(install-polynomial-package)

(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))
