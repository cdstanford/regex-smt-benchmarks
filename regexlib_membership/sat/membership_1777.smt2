;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{5}-\d{4}|\d{5})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "97999"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "9" ""))))))
;witness2: "47805-4511"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "7" (seq.++ "8" (seq.++ "0" (seq.++ "5" (seq.++ "-" (seq.++ "4" (seq.++ "5" (seq.++ "1" (seq.++ "1" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))) ((_ re.loop 5 5) (re.range "0" "9"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
