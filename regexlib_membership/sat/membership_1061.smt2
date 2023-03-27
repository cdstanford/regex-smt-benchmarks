;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([+]31|0031)\s\(0\)([0-9]{9})|([+]31|0031)\s0([0-9]{9})|0([0-9]{9}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0808881286"
(define-fun Witness1 () String (str.++ "0" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "2" (str.++ "8" (str.++ "6" "")))))))))))
;witness2: "+31 0971899648"
(define-fun Witness2 () String (str.++ "+" (str.++ "3" (str.++ "1" (str.++ " " (str.++ "0" (str.++ "9" (str.++ "7" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "4" (str.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (str.to_re (str.++ "+" (str.++ "3" (str.++ "1" "")))) (str.to_re (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "1" ""))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (str.to_re (str.++ "(" (str.++ "0" (str.++ ")" "")))) ((_ re.loop 9 9) (re.range "0" "9")))))(re.union (re.++ (re.union (str.to_re (str.++ "+" (str.++ "3" (str.++ "1" "")))) (str.to_re (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "1" ""))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "0" "0") ((_ re.loop 9 9) (re.range "0" "9"))))) (re.++ (re.range "0" "0") ((_ re.loop 9 9) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
