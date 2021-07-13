#lang sicp

(define (lookup given-key set-of-records)
  (if (null? set-of-records)
      false
      (let ((record (entry set-of-records)))
        (cond ((= given-key (key record))
               record)
              ((< given-key (key record))
               (lookup given-key (left-branch set-of-records)))
              (else (lookup given-key (right-branch set-of-records)))))))