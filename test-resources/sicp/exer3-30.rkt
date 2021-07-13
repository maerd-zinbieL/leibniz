#lang sicp

(define (ripple-carry-adder Ak Bk Sk C)
  ;;; Ak: '(An An-1 ... A3 A2 A1)
  ;;; Bk: '(Bn Bn-1 ... B3 B2 B1)
  ;;; Sk: '(Sn Sn-1 ... S3 S2 S1)
  (define (iter Ak Bk Sk Ck)
    ;;; Ck: '(Cn Cn-1 ... C3 C2 C1 C)
    (if (null? Ak)
        'ok
        (begin
          (full-adder (car Ak)
                      (car Bk)
                      (car Ck)
                      (car S)
                      (cadr Ck))
          (iter (cdr Ak) (cdr Bk) (cdr Sk) (cdr Ck)))))
  (iter Ak Bk Sk (append
                  (map (lambda (x) (make-wire) Ak))
                  (list C))))
  