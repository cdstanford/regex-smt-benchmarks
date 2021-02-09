;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((^\d{5}$)|(^\d{8}$))|(^\d{5}-\d{3}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "96925-987"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "6" (seq.++ "9" (seq.++ "2" (seq.++ "5" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "7" ""))))))))))
;witness2: "88443-843"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "4" (seq.++ "3" (seq.++ "-" (seq.++ "8" (seq.++ "4" (seq.++ "3" ""))))))))))

(assert (= regexA (re.union (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re ""))) (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
