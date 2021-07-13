; (display "Enter input file name: \n")
; (define input-file-name (read))

(define input-file-name "about-not.scm")
(define output-file-name "about-not-assertions.scm")

(define input (open-input-file input-file-name))
(define output (open-output-file output-file-name))


(define (add-assertions input output)
  (let ((assertion (read input)))
    (if (eof-object? assertion)
        (begin
          (close-input-port input)
          (close-output-port output)
          'done)
        (begin
          (display `(assert!  ,assertion))
          (newline)
          (write `(assert!  ,assertion) output)
          (newline output)
          (add-assertions input output)))))

(add-assertions input output)
