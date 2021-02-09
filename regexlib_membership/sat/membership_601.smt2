;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(LV-)[0-9]{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "LV-2458"
(define-fun Witness1 () String (seq.++ "L" (seq.++ "V" (seq.++ "-" (seq.++ "2" (seq.++ "4" (seq.++ "5" (seq.++ "8" ""))))))))
;witness2: "LV-6488"
(define-fun Witness2 () String (seq.++ "L" (seq.++ "V" (seq.++ "-" (seq.++ "6" (seq.++ "4" (seq.++ "8" (seq.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "L" (seq.++ "V" (seq.++ "-" ""))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
