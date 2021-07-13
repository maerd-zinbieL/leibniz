(load "compiler-test.scm")

(define (preserving regs seq1 seq2)
  (if (null? regs)
      (append-instruction-sequences seq1 seq2)
      (let ((first-reg (car regs)))
        (preserving
            (cdr regs)
            (make-instruction-sequence
             (list-union (list first-reg)
                         (registers-needed seq1))
             (list-difference (registers-modified seq1)
                              (list first-reg))
             (append `((save ,first-reg))
                     (statements seq1)
                     `((restore ,first-reg))))
            seq2))))

(define test0
  '(define (count n)
     (if (= n 0)
         'done
         (count (- n 1)))))

(length (test-compiler test0 'val 'next))
;;;未修改 62
;;;修改 118