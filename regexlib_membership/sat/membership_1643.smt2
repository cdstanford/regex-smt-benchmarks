;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^0(6[045679][0469]){1}(\-)?(1)?[^0\D]{1}\d{6}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0696-13798779"
(define-fun Witness1 () String (str.++ "0" (str.++ "6" (str.++ "9" (str.++ "6" (str.++ "-" (str.++ "1" (str.++ "3" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "7" (str.++ "7" (str.++ "9" ""))))))))))))))
;witness2: "060912988037"
(define-fun Witness2 () String (str.++ "0" (str.++ "6" (str.++ "0" (str.++ "9" (str.++ "1" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "3" (str.++ "7" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.++ (re.range "6" "6")(re.++ (re.union (re.range "0" "0")(re.union (re.range "4" "7") (re.range "9" "9"))) (re.union (re.range "0" "0")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9"))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "1" "1"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
