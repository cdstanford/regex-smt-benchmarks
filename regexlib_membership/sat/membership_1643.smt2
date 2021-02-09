;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^0(6[045679][0469]){1}(\-)?(1)?[^0\D]{1}\d{6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0696-13798779"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "6" (seq.++ "9" (seq.++ "6" (seq.++ "-" (seq.++ "1" (seq.++ "3" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "7" (seq.++ "7" (seq.++ "9" ""))))))))))))))
;witness2: "060912988037"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "6" (seq.++ "0" (seq.++ "9" (seq.++ "1" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "3" (seq.++ "7" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.++ (re.range "6" "6")(re.++ (re.union (re.range "0" "0")(re.union (re.range "4" "7") (re.range "9" "9"))) (re.union (re.range "0" "0")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9"))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "1" "1"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
