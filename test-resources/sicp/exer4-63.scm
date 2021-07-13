(assert!
 (son Adam Cain))

(assert!
 (son Cain Enoch))

(assert!
 (son Enoch Irad))

(assert!
 (son Irad Mehujael))

(assert!
 (son Mehujael Methushael))

(assert!
 (son Methushael Lamech))

(assert!
 (wife Lamech Ada))

(assert!
 (son Ada Jabal))

(assert!
 (son Ada Jubal))

(assert!
 (rule (grandson ?g ?s)
       (and (son ?g ?f)
            (son ?f ?s))))

(assert!
 (rule (son ?m ?s)
       (and (wife ?m ?w)
            (son ?w ?s))))
  
;;; Query input:
(grandson Cain ?x)
;;; Query results:
(grandson cain irad)

;;; Query input:
(son Lamech ?x)
;;; Query results:
(son lamech jubal)
(son lamech jabal)

;;; Query input:
(grandson Methushael ?x)
;;; Query results:
(grandson methushael jubal)
(grandson methushael jabal)

