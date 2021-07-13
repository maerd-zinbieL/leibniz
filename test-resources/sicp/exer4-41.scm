;;;help procedures
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(define (permutations s)
  (if (null? s)
      (list '())  
      (flatmap (lambda (x)
                 (map (lambda (p) 
                        (cons x p))
                      (permutations 
                       (remove x s))))
               s)))


(define (multiple-dwelling)
  (define (check solution)
    ;;;baker cooper fletcher miller smith
    (let ((baker (list-ref solution 0))
          (cooper (list-ref  solution 1))
          (fletcher (list-ref  solution 2))
          (miller (list-ref  solution 3))
          (smith (list-ref  solution 4)))
      (and (not (= fletcher 5))
           (not (= fletcher 1))
           (not (= baker 5))
           (not (= cooper 1))
           (> miller cooper)
          ;  (not (= (abs (- smith fletcher)) 1))
           (not (= (abs (- fletcher cooper)) 1))
           )))
  (filter check (permutations '(1 2 3 4 5))))



;;;一开始的版本，丑陋
; (define (inc-mod-5 x)
;   (+ (remainder x 5) 1))

; (define (distinct? items)
;   (cond ((null? items) true)
;         ((null? (cdr items)) true)
;         ((member (car items) (cdr items)) false)
;         (else (distinct? (cdr items)))))

; (define (multiple-dwelling baker cooper fletcher miller smith)  
;   (define (next)
;     (if (= baker cooper fletcher miller smith 5)
;         'done
;         (let ((next-smith (inc-mod-5 smith)))
;             (let ((next-miller
;                  (if (= 5 smith)
;                  (inc-mod-5 miller)
;                  miller)))
;                 (let ((next-fletcher
;                         (if (= 5 smith miller)
;                             (inc-mod-5 fletcher)
;                             fletcher)))
;                     (let ((next-cooper
;                             (if (= 5 smith miller fletcher)
;                                 (inc-mod-5 cooper)
;                                 cooper)))
;                             (let ((next-baker
;                                     (if (= 5 cooper fletcher miller smith)
;                                         (inc-mod-5 baker)
;                                         baker)))
;                                 (multiple-dwelling next-baker
;                                   next-cooper
;                                   next-fletcher
;                                   next-miller
;                                   next-smith))))))))
;   (define (check)
;     (and (distinct? (list baker cooper fletcher miller smith))
;          ;;;上面这行放在最前面好像没有什么效率问题
;          (not (= fletcher 5))
;          (not (= fletcher 1))
;          (not (= baker 5))
;          (not (= cooper 1))
;          (> miller cooper)
;          (not (= (abs (- smith fletcher)) 1))
;          (not (= (abs (- fletcher cooper)) 1))
;          ;(distinct? (list baker cooper fletcher miller smith))
;     ))
;   (define (show-solution baker cooper fletcher miller smith)
;     (newline)
;     (display (list (list 'baker baker)
;              (list 'cooper cooper)
;              (list 'fletcher fletcher)
;              (list 'miller miller)
;              (list 'smith smith)))
;     (newline))
  
;   (if (check)
;       (begin
;         (show-solution baker cooper fletcher miller smith)
;         (next))
;       (next)))

; (multiple-dwelling 1 1 1 1 1)