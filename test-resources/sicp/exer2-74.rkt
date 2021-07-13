#lang sicp

#|
每个分支机构应该提供的方法:get-rord,get-salary
|#

(#%required "type.rkt")
(define (get-record employee-name division-file)
  (let ((record ((get 'get-record (type-tag division-file))
                  employee-name)))
    (if (null? record)
        false
        (attach-tag (type-tag file) record))))

(define (get-salary record)
  ((get 'get-salary (type-tag record)) (contents record)))

(define (find-employee-record employee-name division-files)
  (map get-record division-files))