;;;a)
(meeting ?div (Friday ?time))

;;;b)
(assert!
 (rule (meeting-time ?person ?day-and-time)
       (or (meeting whole-company ?day-and-time)
           (and (job ?person (?div . ?))
                (meeting ?div ?day-and-time)))))

;;;c)
(meeting-time (Hacker Alyssa P) (Wednesday ?time))