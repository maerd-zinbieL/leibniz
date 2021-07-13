#lang sicp
(#%require "type.rkt")
(#%require "table.rkt")
(#%require "generic.rkt")

(#%require "install-complex-package.rkt")
(#%require "install-number-package.rkt")
(#%require "install-real-package.rkt")
(#%require "install-rational-package.rkt")
;;;http://community.schemewiki.org/?sicp-ex-2.86
;; Converting data types to scheme-number

(define square (lambda (x) (* x x)))

 (define (install-type->scheme-number-package) 
     ;; real -> scheme-number 
     (put 'get-scheme-number '(real) 
         (lambda (x) (make-scheme-number x))) 
      
     ;; rational -> scheme-number 
     (put 'get-scheme-number '(rational) 
         (lambda (r) 
             (make-scheme-number 
                 (contents (div ((get 'numer '(rational)) r)
                                ((get 'denom '(rational)) r)))))) 
      
     ;; scheme-number -> scheme-number 
     (put 'get-scheme-number '(scheme-number) 
         (lambda (x) (make-scheme-number x))) 
      
     'done) 
  
 ;; Conversion interface 
 (define (get-scheme-number x) 
     (apply-generic 'get-scheme-number x)) 
  
 ;; To rewrite basic operations into a form that can handle combined data 
 ;; Return the result as scheme-number 
 (define (decorator f) 
     ;; Unified input 
     (define (transform args) 
         (map 
             (lambda (arg) 
                 (if (number? arg) 
                     (make-scheme-number arg) 
                     (get-scheme-number arg))) 
             args)) 
      
     ;; Unified output 
     (lambda (first . other) 
         (make-scheme-number 
             (let ((args (map 
                             contents 
                             (transform (cons first other))))) 
                 (apply f args))))) 
  
 ;; To rewrite basic operations with decorator 
 ;; You can also write like this: 
 ;;     (set! + (decorator +)) 
 ;; So you don't have to change the code of complex package. 
 ;; But once you do that, the other packages will suffer. 
 (define new-square (decorator square)) 
 (define new-sqrt (decorator sqrt)) 
 (define new-add (decorator +)) 
 (define new-sub (decorator -)) 
 (define new-mul (decorator *)) 
 (define new-div (decorator /)) 
 (define sine (decorator sin)) 
 (define cosine (decorator cos)) 
 (define new-atan (decorator atan)) 