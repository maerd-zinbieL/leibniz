(assert! (rule (replace ?p1 ?p2)
               (and (job ?p1 ?job1)
                    (job ?p2 ?job2)
                    (or (same ?job1 ?job2)
                        (can-do-job ?job1 ?job2))
                    (not (same ?p1 ?p2)))))

;;;a)
(replace ?person (Fect Cy D))

;;;b)
(and (salary ?person ?amount1)
     (salary ?someone ?amount2)
     (replace ?person ?someone)
     (lisp-value > ?amount1 ?amount2))
          
          