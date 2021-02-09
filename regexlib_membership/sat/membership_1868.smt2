;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(4|5)\d{3}-?\d{4}-?\d{4}-?\d{4}|(4|5)\d{15})|(^(6011)-?\d{4}-?\d{4}-?\d{4}|(6011)-?\d{12})|(^((3\d{3}))-\d{6}-\d{5}|^((3\d{14})))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3999-289916-04937\u00D8"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "1" (seq.++ "6" (seq.++ "-" (seq.++ "0" (seq.++ "4" (seq.++ "9" (seq.++ "3" (seq.++ "7" (seq.++ "\xd8" "")))))))))))))))))))
;witness2: "387099391899883"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "8" (seq.++ "7" (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "3" ""))))))))))))))))

(assert (= regexA (re.union (re.union (re.++ (str.to_re "")(re.++ (re.range "4" "5")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9")))))))))) (re.++ (re.range "4" "5") ((_ re.loop 15 15) (re.range "0" "9"))))(re.union (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" "")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (re.++ (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" "")))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 12 12) (re.range "0" "9"))))) (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "3" "3") ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 5 5) (re.range "0" "9"))))))) (re.++ (str.to_re "") (re.++ (re.range "3" "3") ((_ re.loop 14 14) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
