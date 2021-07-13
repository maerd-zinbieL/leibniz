(gcd 40 (remainder 206 40))

(gcd (remainder 206 40)
     (remainder 40
                (remainder 206 40)))

(gcd (remainder 40
                (remainder 206 40))
     (remainder (remainder 206 40)
                (remainder 40
                           (remainder 206 40))))

(gcd (remainder (remainder 206 40)
                (remainder 40
                           (remainder 206 40)))
     (remainder (remainder 40
                           (remainder 206 40))
                (remainder (remainder 206 40)
                           (remainder 40
                                      (remainder 206 40)))))