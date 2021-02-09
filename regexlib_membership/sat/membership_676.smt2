;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)\s*[,]{0,1}\s*)+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AA@57.\u00E2.d.9\xD5lqu8\u00E7+\u00B5@\u00BA1.\u00AA0.\u00E43E.\u00C2e9-5\u00A0\u00A0"
(define-fun Witness1 () String (seq.++ "\xaa" (seq.++ "@" (seq.++ "5" (seq.++ "7" (seq.++ "." (seq.++ "\xe2" (seq.++ "." (seq.++ "d" (seq.++ "." (seq.++ "9" (seq.++ "\x0d" (seq.++ "5" (seq.++ "l" (seq.++ "q" (seq.++ "u" (seq.++ "8" (seq.++ "\xe7" (seq.++ "+" (seq.++ "\xb5" (seq.++ "@" (seq.++ "\xba" (seq.++ "1" (seq.++ "." (seq.++ "\xaa" (seq.++ "0" (seq.++ "." (seq.++ "\xe4" (seq.++ "3" (seq.++ "E" (seq.++ "." (seq.++ "\xc2" (seq.++ "e" (seq.++ "9" (seq.++ "-" (seq.++ "5" (seq.++ "\xa0" (seq.++ "\xa0" ""))))))))))))))))))))))))))))))))))))))
;witness2: "\u00D0@\u00B5.03z\u00E39\u00F69\u00B5-1, \u00F8\u00F9+0pm5@Q-\u00AA\u00CC.\u00B5\u00FB\u00FB8 , \u00A0"
(define-fun Witness2 () String (seq.++ "\xd0" (seq.++ "@" (seq.++ "\xb5" (seq.++ "." (seq.++ "0" (seq.++ "3" (seq.++ "z" (seq.++ "\xe3" (seq.++ "9" (seq.++ "\xf6" (seq.++ "9" (seq.++ "\xb5" (seq.++ "-" (seq.++ "1" (seq.++ "," (seq.++ " " (seq.++ "\xf8" (seq.++ "\xf9" (seq.++ "+" (seq.++ "0" (seq.++ "p" (seq.++ "m" (seq.++ "5" (seq.++ "@" (seq.++ "Q" (seq.++ "-" (seq.++ "\xaa" (seq.++ "\xcc" (seq.++ "." (seq.++ "\xb5" (seq.++ "\xfb" (seq.++ "\xfb" (seq.++ "8" (seq.++ " " (seq.++ "," (seq.++ " " (seq.++ "\xa0" ""))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.union (re.range "+" "+") (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.range "-" ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.* (re.++ (re.range "-" ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "," ",")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
