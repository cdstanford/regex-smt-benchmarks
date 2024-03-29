;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((4\d{3})|(5[1-5]\d{2})|(6011))-?\d{4}-?\d{4}-?\d{4}|3[4,7]\d{13}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4919-999888832228"
(define-fun Witness1 () String (str.++ "4" (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "2" (str.++ "2" (str.++ "2" (str.++ "8" ""))))))))))))))))))
;witness2: "484419991880-9499"
(define-fun Witness2 () String (str.++ "4" (str.++ "8" (str.++ "4" (str.++ "4" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "-" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "9" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "4" "4") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "5" "5")(re.++ (re.range "1" "5") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re (str.++ "6" (str.++ "0" (str.++ "1" (str.++ "1" "")))))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (re.++ (re.range "3" "3")(re.++ (re.union (re.range "," ",")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
