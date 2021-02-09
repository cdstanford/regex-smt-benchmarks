;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^0(5[012345678]|6[47]){1}(\-)?[^0\D]{1}\d{5}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "057979749"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ "7" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "7" (seq.++ "4" (seq.++ "9" ""))))))))))
;witness2: "057788692"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "5" (seq.++ "7" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "2" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.union (re.++ (re.range "5" "5") (re.range "0" "8")) (re.++ (re.range "6" "6") (re.union (re.range "4" "4") (re.range "7" "7"))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
