(Greek Socrates)
(Greek Plato)
(Greek Zeus)
(god Zeus)

(rule (mortal ?x) (human ?x))
(rule (fallible ?x) (human ?x))

(rule (human ?x)
      (and (Greek ?x) (not (god ?x))))

(rule (address ?x Olympus)
      (and (Greek ?x) (god ?x)))

(rule (perfect ?x)
      (and (not (mortal ?x))
           (not (fallible ?x))))


(perfect ?x)
(perfect Zeus)
; (and (address ?x ?y)
;      (perfect ?x))

; (and (perfect ?x)
;      (address ?x ?y))