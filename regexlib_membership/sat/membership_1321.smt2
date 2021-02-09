;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{5}(-\d{4})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "48866-2008"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "6" (seq.++ "-" (seq.++ "2" (seq.++ "0" (seq.++ "0" (seq.++ "8" "")))))))))))
;witness2: "33098"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "3" (seq.++ "0" (seq.++ "9" (seq.++ "8" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
