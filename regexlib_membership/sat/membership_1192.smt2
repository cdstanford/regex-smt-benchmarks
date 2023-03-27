;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 29\sFebruary\s((0[48]|[2468][048]|[13579][26])00|[0-9]{2}(0[48]|[2468][048]|[13579][26]))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "29\xAFebruary\u00A00400\u008C"
(define-fun Witness1 () String (str.++ "2" (str.++ "9" (str.++ "\u{0a}" (str.++ "F" (str.++ "e" (str.++ "b" (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" (str.++ "\u{a0}" (str.++ "0" (str.++ "4" (str.++ "0" (str.++ "0" (str.++ "\u{8c}" ""))))))))))))))))))
;witness2: "29\u0085February\xC2400"
(define-fun Witness2 () String (str.++ "2" (str.++ "9" (str.++ "\u{85}" (str.++ "F" (str.++ "e" (str.++ "b" (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" (str.++ "\u{0c}" (str.++ "2" (str.++ "4" (str.++ "0" (str.++ "0" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (str.to_re (str.++ "F" (str.++ "e" (str.++ "b" (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" "")))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re (str.++ "0" (str.++ "0" "")))) (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
