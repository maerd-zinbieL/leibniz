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
  
(assert! (rule (end-in-grandson (grandson))))

(assert! (rule (end-in-grandson (?gs . ?rest))
               (end-in-grandson ?rest)))

(assert! (rule ((grandson) ?g ?gs)
               (grandson ?g ?gs)))

(assert! (rule ((great . ?rest) ?g ?gss)
               (and
                (son ?g ?f)
                (?rest ?f ?gss)
                ;;;必须在最后
                (end-in-grandson ?rest)
                )))

;;; Query input:
((great grandson) ?g ?ggs)
;;; Query results:
((great grandson) mehujael jubal)
((great grandson) irad lamech)
((great grandson) mehujael jabal)
((great grandson) enoch methushael)
((great grandson) cain mehujael)
((great grandson) adam irad)

;;; Query input:
(?relationship Adam Irad)
;;; Query results:
((great grandson) adam irad)

;;; Query input:
(?relationship Adam Jabal)
;;; Query results:
((great great great great great grandson) adam jabal)