;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(4|5)\d{3}-?\d{4}-?\d{4}-?\d{4}|(4|5)\d{15})|(^(6011)-?\d{4}-?\d{4}-?\d{4}|(6011)-?\d{12})|(^((3\d{3}))-\d{6}-\d{5}|^((3\d{14})))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3999-289916-04937\u00D8"
(define-fun Witness1 () String (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "6" (str.++ "-" (str.++ "0" (str.++ "4" (str.++ "9" (str.++ "3" (str.++ "7" (str.++ "\u{d8}" "")))))))))))))))))))
;witness2: "387099391899883"
(define-fun Witness2 () String (str.++ "3" (str.++ "8" (str.++ "7" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "3" ""))))))))))))))))

(assert (= regexA (re.union (re.union (re.++ (str.to_re "")(re.++ (re.range "4" "5")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9")))))))))) (re.++ (re.range "4" "5") ((_ re.loop 15 15) (re.range "0" "9"))))(re.union (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "6" (str.++ "0" (str.++ "1" (str.++ "1" "")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (re.++ (str.to_re (str.++ "6" (str.++ "0" (str.++ "1" (str.++ "1" "")))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 12 12) (re.range "0" "9"))))) (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "3" "3") ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 5 5) (re.range "0" "9"))))))) (re.++ (str.to_re "") (re.++ (re.range "3" "3") ((_ re.loop 14 14) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
