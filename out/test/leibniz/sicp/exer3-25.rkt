#lang sicp

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (has-subtable? records)
      (cond ((null? records)
             false)
            ((pair? (cdar records))
             true)
            (else (has-subtable? (cdr records)))))
    
    (define (lookup origin-keys)
      (define (iter keys table)
        (if (null? keys)
            (cdr table)
            (let ((next (assoc (car keys) (cdr table))))
              ;(display next)
              ;(newline)
              (if next
                  (if (has-subtable? (cdr next))
                      (iter (cdr keys) next)
                      (if (null? (cdr keys))
                          (error "containing redundant keys: LOOKUP," keys )
                          (let ((record (assoc (cadr keys) (cdr next))))
                            (if record
                                (cdr record)
                                false))))
                  false))))
      (iter origin-keys local-table))

    (define (insert! origin-keys value)
      (define (make-stairs keys value)
        (cond ((null? keys)
               value)
              ((= 1 (length keys))
               (cons (car keys)
                     value))
              (else
               (cons (car keys)
                     (list (make-stairs (cdr keys) value))))))
      (define (rec keys value table)
        (let ((next (assoc (car keys) (cdr table))))
          (display "table ")
          (display table)
          (newline)
          (display "keys ")
          (display keys)
          (newline)
          (if next
              (if (has-subtable? (cdr next))
                  (if (null? (cdr keys))
                      (error "final key cannot be a table name")
                      (rec (cdr keys) value next))
                  (set! next (make-stairs (cdr keys) value)))
              (let ((stairs (make-stairs  keys value)))
                (set-cdr! table
                          (cons stairs 
                                (cdr table)))))))
      (rec origin-keys value local-table))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'get-table) local-table)
            (else (error "Unknown operation: 
                          TABLE" m))))
    dispatch))

(define (lookup keys table)
  ((table 'lookup-proc) keys))
(define (insert! keys value table)
  ((table 'insert-proc!) keys value))


;;;;;;test
(define table (make-table))

(insert! '(k3 k2 *) 2 table)
;(display (table 'get-table))
(newline)

(insert! '(k3 k2 *) 5 table)
;(display (table 'get-table))
(newline)

(lookup '(k3 k2 *) table)