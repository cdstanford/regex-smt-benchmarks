;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)\s*[,]{0,1}\s*)+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AA@57.\u00E2.d.9\xD5lqu8\u00E7+\u00B5@\u00BA1.\u00AA0.\u00E43E.\u00C2e9-5\u00A0\u00A0"
(define-fun Witness1 () String (str.++ "\u{aa}" (str.++ "@" (str.++ "5" (str.++ "7" (str.++ "." (str.++ "\u{e2}" (str.++ "." (str.++ "d" (str.++ "." (str.++ "9" (str.++ "\u{0d}" (str.++ "5" (str.++ "l" (str.++ "q" (str.++ "u" (str.++ "8" (str.++ "\u{e7}" (str.++ "+" (str.++ "\u{b5}" (str.++ "@" (str.++ "\u{ba}" (str.++ "1" (str.++ "." (str.++ "\u{aa}" (str.++ "0" (str.++ "." (str.++ "\u{e4}" (str.++ "3" (str.++ "E" (str.++ "." (str.++ "\u{c2}" (str.++ "e" (str.++ "9" (str.++ "-" (str.++ "5" (str.++ "\u{a0}" (str.++ "\u{a0}" ""))))))))))))))))))))))))))))))))))))))
;witness2: "\u00D0@\u00B5.03z\u00E39\u00F69\u00B5-1, \u00F8\u00F9+0pm5@Q-\u00AA\u00CC.\u00B5\u00FB\u00FB8 , \u00A0"
(define-fun Witness2 () String (str.++ "\u{d0}" (str.++ "@" (str.++ "\u{b5}" (str.++ "." (str.++ "0" (str.++ "3" (str.++ "z" (str.++ "\u{e3}" (str.++ "9" (str.++ "\u{f6}" (str.++ "9" (str.++ "\u{b5}" (str.++ "-" (str.++ "1" (str.++ "," (str.++ " " (str.++ "\u{f8}" (str.++ "\u{f9}" (str.++ "+" (str.++ "0" (str.++ "p" (str.++ "m" (str.++ "5" (str.++ "@" (str.++ "Q" (str.++ "-" (str.++ "\u{aa}" (str.++ "\u{cc}" (str.++ "." (str.++ "\u{b5}" (str.++ "\u{fb}" (str.++ "\u{fb}" (str.++ "8" (str.++ " " (str.++ "," (str.++ " " (str.++ "\u{a0}" ""))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.++ (re.union (re.range "+" "+") (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.++ (re.range "-" ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.* (re.++ (re.range "-" ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "," ",")) (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
