;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (DELETE\sFROM\s[\d\w\'\=]+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E0DELETE\u00A0FROM \'\u00AF\u00FD"
(define-fun Witness1 () String (str.++ "\u{e0}" (str.++ "D" (str.++ "E" (str.++ "L" (str.++ "E" (str.++ "T" (str.++ "E" (str.++ "\u{a0}" (str.++ "F" (str.++ "R" (str.++ "O" (str.++ "M" (str.++ " " (str.++ "'" (str.++ "\u{af}" (str.++ "\u{fd}" "")))))))))))))))))
;witness2: "DELETE FROM\u0085\u00B5\u00AA"
(define-fun Witness2 () String (str.++ "D" (str.++ "E" (str.++ "L" (str.++ "E" (str.++ "T" (str.++ "E" (str.++ " " (str.++ "F" (str.++ "R" (str.++ "O" (str.++ "M" (str.++ "\u{85}" (str.++ "\u{b5}" (str.++ "\u{aa}" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "D" (str.++ "E" (str.++ "L" (str.++ "E" (str.++ "T" (str.++ "E" "")))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (str.to_re (str.++ "F" (str.++ "R" (str.++ "O" (str.++ "M" "")))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.+ (re.union (re.range "'" "'")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
