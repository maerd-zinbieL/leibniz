; (assert! (rule (big-shot ?p)
;                (and (job ?p (?div1 . ?rest1))
;                     (supervisor ?p ?boss)
;                     (job ?boss (?div2 . ?rest2))
;                     (not (same ?div1 ?div2)))))

(assert! (rule (big-shot-v2 ?p ?div)
               (and (job ?p (?div . ?rest1))
                    (or (not (supervisor ?p ?boss))
                        (and (supervisor ?p ?boss)
                             (not (job ?boss (?div . ?rest2))))))))
               