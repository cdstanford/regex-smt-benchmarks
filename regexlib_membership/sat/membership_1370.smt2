;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{3}|\d{4})[-](\d{5})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8898-29341"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "4" (seq.++ "1" "")))))))))))
;witness2: "9016-12886"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "0" (seq.++ "1" (seq.++ "6" (seq.++ "-" (seq.++ "1" (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "6" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9")) ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
