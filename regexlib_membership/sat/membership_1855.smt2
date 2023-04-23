;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((0?[13578]|10|12)(-|\/)((0[0-9])|([12])([0-9]?)|(3[01]?))(-|\/)((\d{4})|(\d{2}))|(0?[2469]|11)(-|\/)((0[0-9])|([12])([0-9]?)|(3[0]?))(-|\/)((\d{4}|\d{2})))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "12-1-98"
(define-fun Witness1 () String (str.++ "1" (str.++ "2" (str.++ "-" (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "8" ""))))))))
;witness2: "10-04/4488\u00D1\u009D\u00D0\x191"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" (str.++ "-" (str.++ "0" (str.++ "4" (str.++ "/" (str.++ "4" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "\u{d1}" (str.++ "\u{9d}" (str.++ "\u{d0}" (str.++ "\u{19}" (str.++ "1" ""))))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))))(re.union (str.to_re (str.++ "1" (str.++ "0" ""))) (str.to_re (str.++ "1" (str.++ "2" "")))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "2") (re.opt (re.range "0" "9"))) (re.++ (re.range "3" "3") (re.opt (re.range "0" "1")))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9"))))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9"))))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "2") (re.opt (re.range "0" "9"))) (re.++ (re.range "3" "3") (re.opt (re.range "0" "0")))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
