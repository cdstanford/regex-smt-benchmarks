;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0?[13578]|10|12)(-|\/)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1/31-1988"
(define-fun Witness1 () String (str.++ "1" (str.++ "/" (str.++ "3" (str.++ "1" (str.++ "-" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "8" ""))))))))))
;witness2: "02-19/2016"
(define-fun Witness2 () String (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "1" (str.++ "9" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "1" (str.++ "6" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))))(re.union (str.to_re (str.++ "1" (str.++ "0" ""))) (str.to_re (str.++ "1" (str.++ "2" "")))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.range "1" "9")(re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.opt (re.range "0" "9"))) (re.++ (re.range "3" "3") (re.opt (re.range "0" "1"))))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" "")))(re.++ (re.range "2" "9") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "0" "")))(re.++ (re.range "0" "1") (re.range "0" "9"))) (re.++ (re.union (re.range "0" "1") (re.range "8" "9")) (re.range "0" "9")))))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9"))))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.range "1" "9")(re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.opt (re.range "0" "9"))) (re.++ (re.range "3" "3") (re.opt (re.range "0" "0"))))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" "")))(re.++ (re.range "2" "9") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "0" "")))(re.++ (re.range "0" "1") (re.range "0" "9"))) (re.++ (re.union (re.range "0" "1") (re.range "8" "9")) (re.range "0" "9"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
