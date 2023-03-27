;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (077|078|079)\s?\d{2}\s?\d{6}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "078\u00A088\u0085848989K^"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ "8" (str.++ "\u{a0}" (str.++ "8" (str.++ "8" (str.++ "\u{85}" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "K" (str.++ "^" ""))))))))))))))))
;witness2: "\u0086079\u008581291751\u00DAg"
(define-fun Witness2 () String (str.++ "\u{86}" (str.++ "0" (str.++ "7" (str.++ "9" (str.++ "\u{85}" (str.++ "8" (str.++ "1" (str.++ "2" (str.++ "9" (str.++ "1" (str.++ "7" (str.++ "5" (str.++ "1" (str.++ "\u{da}" (str.++ "g" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "0" (str.++ "7" (str.++ "7" ""))))(re.union (str.to_re (str.++ "0" (str.++ "7" (str.++ "8" "")))) (str.to_re (str.++ "0" (str.++ "7" (str.++ "9" ""))))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 6 6) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
