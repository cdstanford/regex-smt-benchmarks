;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((\d{4}((0[13578]|1[02])(0[1-9]|[12]\d|3[01])|(0[13456789]|1[012])(0[1-9]|[12]\d|30)|02(0[1-9]|1\d|2[0-8])))|((\d{2}[02468][048]|\d{2}[13579][26]))0229)){0,8}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "97880229888802295884010687080229"
(define-fun Witness1 () String (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "0" (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "8" (str.++ "7" (str.++ "0" (str.++ "8" (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" "")))))))))))))))))))))))))))))))))
;witness2: "9958021698440229"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "0" (str.++ "2" (str.++ "1" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "4" (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 8) (re.union (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2")))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))) (re.++ (str.to_re (str.++ "0" (str.++ "2" ""))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))))))) (re.++ (re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))) (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" "")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
