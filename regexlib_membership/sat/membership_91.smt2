;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\s(SUN|MON|TUE|WED|THU|FRI|SAT)\s+(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)\s+(0?[1-9]|[1-2][0-9]|3[01])\s+(2[0-3]|[0-1][0-9]):([0-5][0-9]):((60|[0-5][0-9]))\s+(19[0-9]{2}|[2-9][0-9]{3}|[0-9]{2}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0085WED JUL\u0085\xD\u00A0\u00A0 \u008506\xD 21:59:58\xC\u0085\u00A0 89"
(define-fun Witness1 () String (str.++ "\u{85}" (str.++ "W" (str.++ "E" (str.++ "D" (str.++ " " (str.++ "J" (str.++ "U" (str.++ "L" (str.++ "\u{85}" (str.++ "\u{0d}" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ " " (str.++ "\u{85}" (str.++ "0" (str.++ "6" (str.++ "\u{0d}" (str.++ " " (str.++ "2" (str.++ "1" (str.++ ":" (str.++ "5" (str.++ "9" (str.++ ":" (str.++ "5" (str.++ "8" (str.++ "\u{0c}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ " " (str.++ "8" (str.++ "9" "")))))))))))))))))))))))))))))))))
;witness2: "\u0085SUN\u0085AUG 28\xC23:59:60\u00851970"
(define-fun Witness2 () String (str.++ "\u{85}" (str.++ "S" (str.++ "U" (str.++ "N" (str.++ "\u{85}" (str.++ "A" (str.++ "U" (str.++ "G" (str.++ " " (str.++ "2" (str.++ "8" (str.++ "\u{0c}" (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "5" (str.++ "9" (str.++ ":" (str.++ "6" (str.++ "0" (str.++ "\u{85}" (str.++ "1" (str.++ "9" (str.++ "7" (str.++ "0" ""))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (str.to_re (str.++ "S" (str.++ "U" (str.++ "N" ""))))(re.union (str.to_re (str.++ "M" (str.++ "O" (str.++ "N" ""))))(re.union (str.to_re (str.++ "T" (str.++ "U" (str.++ "E" ""))))(re.union (str.to_re (str.++ "W" (str.++ "E" (str.++ "D" ""))))(re.union (str.to_re (str.++ "T" (str.++ "H" (str.++ "U" ""))))(re.union (str.to_re (str.++ "F" (str.++ "R" (str.++ "I" "")))) (str.to_re (str.++ "S" (str.++ "A" (str.++ "T" ""))))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (str.to_re (str.++ "J" (str.++ "A" (str.++ "N" ""))))(re.union (str.to_re (str.++ "F" (str.++ "E" (str.++ "B" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "R" ""))))(re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "R" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "Y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "N" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "L" ""))))(re.union (str.to_re (str.++ "A" (str.++ "U" (str.++ "G" ""))))(re.union (str.to_re (str.++ "S" (str.++ "E" (str.++ "P" ""))))(re.union (str.to_re (str.++ "O" (str.++ "C" (str.++ "T" ""))))(re.union (str.to_re (str.++ "N" (str.++ "O" (str.++ "V" "")))) (str.to_re (str.++ "D" (str.++ "E" (str.++ "C" "")))))))))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "3")) (re.++ (re.range "0" "1") (re.range "0" "9")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.union (str.to_re (str.++ "6" (str.++ "0" ""))) (re.++ (re.range "0" "5") (re.range "0" "9")))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" ""))) ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9"))) ((_ re.loop 2 2) (re.range "0" "9"))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
