;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^3[47])((\d{11}$)|(\d{13}$))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "371307368319319"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "7" (seq.++ "1" (seq.++ "3" (seq.++ "0" (seq.++ "7" (seq.++ "3" (seq.++ "6" (seq.++ "8" (seq.++ "3" (seq.++ "1" (seq.++ "9" (seq.++ "3" (seq.++ "1" (seq.++ "9" ""))))))))))))))))
;witness2: "3799540681890"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "4" (seq.++ "0" (seq.++ "6" (seq.++ "8" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "0" ""))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re "")(re.++ (re.range "3" "3") (re.union (re.range "4" "4") (re.range "7" "7")))) (re.union (re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
