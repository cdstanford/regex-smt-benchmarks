;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (0[1-9]|[12][0-9]|3[01])\s(J(anuary|uly)|Ma(rch|y)|August|(Octo|Decem)ber)\s[1-9][0-9]{3}|
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.range "J" "J") (re.union (str.to_re (str.++ "a" (str.++ "n" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))) (str.to_re (str.++ "u" (str.++ "l" (str.++ "y" ""))))))(re.union (re.++ (str.to_re (str.++ "M" (str.++ "a" ""))) (re.union (str.to_re (str.++ "r" (str.++ "c" (str.++ "h" "")))) (re.range "y" "y")))(re.union (str.to_re (str.++ "A" (str.++ "u" (str.++ "g" (str.++ "u" (str.++ "s" (str.++ "t" ""))))))) (re.++ (re.union (str.to_re (str.++ "O" (str.++ "c" (str.++ "t" (str.++ "o" ""))))) (str.to_re (str.++ "D" (str.++ "e" (str.++ "c" (str.++ "e" (str.++ "m" ""))))))) (str.to_re (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9"))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
