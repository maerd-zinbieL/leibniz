(assert!
 (rule (append-to-form () ?y ?y)))

(assert!
 (rule (append-to-form (?u . ?v) ?y (?u . ?z))
       (append-to-form ?v ?y ?z)))

; (define (reverse seq) 
;    (if (null? seq) 
;        '() 
;        (append (reverse (cdr seq)) (list (car seq)))))

(assert!
 (rule (reverse () ())))

(assert!
 (rule (reverse (?x . ?y) ?z)
       (and
        ;;;无论如何调换这两行的顺序，
        ;;;对于(reverse (1 2 3) ?x) and (reverse ?x (1 2 3))
        ;;;总会有一个query陷入死循环。
        (append-to-form ?ry (?x) ?z)
        (reverse ?y ?ry))))