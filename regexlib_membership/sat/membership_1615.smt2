;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(3[0-1]|2[0-9]|1[0-9]|0[1-9])[\s{1}|\/|-](Jan|JAN|Feb|FEB|Mar|MAR|Apr|APR|May|MAY|Jun|JUN|Jul|JUL|Aug|AUG|Sep|SEP|Oct|OCT|Nov|NOV|Dec|DEC)[\s{1}|\/|-]\d{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "05\u0085MAR19802"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ "\x85" (seq.++ "M" (seq.++ "A" (seq.++ "R" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "2" ""))))))))))))
;witness2: "31\u00A0JUN}8955"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "1" (seq.++ "\xa0" (seq.++ "J" (seq.++ "U" (seq.++ "N" (seq.++ "}" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "5" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "3" "3") (re.range "0" "1"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "0" "0") (re.range "1" "9")))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "1" "1")(re.union (re.range "{" "}")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ (re.union (str.to_re (seq.++ "J" (seq.++ "a" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "A" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "e" (seq.++ "b" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "E" (seq.++ "B" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "a" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "A" (seq.++ "R" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "P" (seq.++ "R" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "a" (seq.++ "y" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "A" (seq.++ "Y" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "U" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "U" (seq.++ "L" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "u" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "U" (seq.++ "G" ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "e" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "E" (seq.++ "P" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "c" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "C" (seq.++ "T" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "o" (seq.++ "v" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "O" (seq.++ "V" ""))))(re.union (str.to_re (seq.++ "D" (seq.++ "e" (seq.++ "c" "")))) (str.to_re (seq.++ "D" (seq.++ "E" (seq.++ "C" "")))))))))))))))))))))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "/" "/")(re.union (re.range "1" "1")(re.union (re.range "{" "}")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
