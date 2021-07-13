#lang sicp


(define count 0)

(define (move n from to)
  (set! count (+ count 1))
  (display "[")
  (display n)
  (display ": ")
  (display from)
  (display "->")
  (display to)
  (display "]  "))


(define (current-status n from to temp)
  (display n)
  (display " ")
  (display from)
  (display " ")
  (display to)
  (display " ")
  (display temp)
  (newline))


(define (hanoi-rec n from to temp)
  ;;; (current-status n from to temp)
  (cond ((= n 1) (move 1 from to))
        (else (hanoi-rec (- n 1) from temp to)
              (move n from to)
              (hanoi-rec (- n 1) temp to from))))


(define (hanoi-iter-0 from to temp n)
  ("pass"))

(hanoi-rec 5 "A" "C" "B")

