;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{2,6}-\d{2}-\d$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "34-22-4"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "4" (seq.++ "-" (seq.++ "2" (seq.++ "2" (seq.++ "-" (seq.++ "4" ""))))))))
;witness2: "88-41-8"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "4" (seq.++ "1" (seq.++ "-" (seq.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 6) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.range "0" "9") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
