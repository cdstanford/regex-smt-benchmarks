;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(3[0-1]|2[0-9]|1[0-9]|0[1-9])[\s{1}|\/|-](Jan|JAN|Feb|FEB|Mar|MAR|Apr|APR|May|MAY|Jun|JUN|Jul|JUL|Aug|AUG|Sep|SEP|Oct|OCT|Nov|NOV|Dec|DEC)[\s{1}|\/|-]\d{4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "05\u0085MAR19802"
(define-fun Witness1 () String (str.++ "0" (str.++ "5" (str.++ "\u{85}" (str.++ "M" (str.++ "A" (str.++ "R" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "2" ""))))))))))))
;witness2: "31\u00A0JUN}8955"
(define-fun Witness2 () String (str.++ "3" (str.++ "1" (str.++ "\u{a0}" (str.++ "J" (str.++ "U" (str.++ "N" (str.++ "}" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "5" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "3" "3") (re.range "0" "1"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "0" "0") (re.range "1" "9")))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "1" "1")(re.union (re.range "{" "}")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ (re.union (str.to_re (str.++ "J" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "A" (str.++ "N" ""))))(re.union (str.to_re (str.++ "F" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "F" (str.++ "E" (str.++ "B" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "R" ""))))(re.union (str.to_re (str.++ "A" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "R" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "Y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "N" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "L" ""))))(re.union (str.to_re (str.++ "A" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "A" (str.++ "U" (str.++ "G" ""))))(re.union (str.to_re (str.++ "S" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "S" (str.++ "E" (str.++ "P" ""))))(re.union (str.to_re (str.++ "O" (str.++ "c" (str.++ "t" ""))))(re.union (str.to_re (str.++ "O" (str.++ "C" (str.++ "T" ""))))(re.union (str.to_re (str.++ "N" (str.++ "o" (str.++ "v" ""))))(re.union (str.to_re (str.++ "N" (str.++ "O" (str.++ "V" ""))))(re.union (str.to_re (str.++ "D" (str.++ "e" (str.++ "c" "")))) (str.to_re (str.++ "D" (str.++ "E" (str.++ "C" "")))))))))))))))))))))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "1" "1")(re.union (re.range "{" "}")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
