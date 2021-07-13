#lang sicp

(#%require "queue.rkt")

(define q1 (make-queue))

(display-queue (insert-queue! q1 'a))
; ((a) a)

(display-queue(insert-queue! q1 'b))
; ((a b) b)

(display-queue(delete-queue! q1))
; ((b) b)

(display-queue(delete-queue! q1))
; (() b)