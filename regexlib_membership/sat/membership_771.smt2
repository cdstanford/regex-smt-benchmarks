;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{0,2})-([0-9]{0,2})-([0-9]{0,4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "95-52-8"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "5" (seq.++ "-" (seq.++ "5" (seq.++ "2" (seq.++ "-" (seq.++ "8" ""))))))))
;witness2: "-9-"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "9" (seq.++ "-" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 0 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
