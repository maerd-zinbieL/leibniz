; (define (p->q p q)
;   (or (not p) q))
;;;
; 令CD, Mr.H, Sir.B, DP, Mr.M分别为a,b,c,d,e，
; Melissa,Rosalind,Gabrielle,Mary Ann Moore,Lorna分别为1,2,3,4,5。

; X = Y => X对应的人是Y对应的人的爸爸。

; Mary Ann Moore's father is Mr.Moore => e = 5

; Sir Barnacle’s yacht is the Gabrielle => c != 3

; Mr. Moore owns the Lorna => e != 5

; Mr. Hall owns the Rosalind => b != 2
; The Melissa, owned by Colonel Downing,
; is named after Sir Barnacle’s daughter => a != 1, c=1

; Gabrielle’s father owns the yacht that is
; named after Dr. Parker’s daughter =>
; 要么a = 3，并且d = 1,要么b = 3,并且d = 2,要么e = 3,并且d = 5。

(define (lorna-father)
  (let ((a (amb 2 3 4 5))
        (b (amb 3 4 5))
        (d (amb 2 3 5))
        (e 4))
    (require
     (or (and (= a 3) (= d 1))
         (and (= b 3) (= d 2))
         (and (= e 3) (= d 5))))
    (let ((c 1))
      (require (distinct? (list a b c d e)))
      (list a b c d e))))

(lorna-father)