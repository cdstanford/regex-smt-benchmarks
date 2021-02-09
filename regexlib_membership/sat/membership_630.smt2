;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\$YYYY\$\$MM\$\$DD\$$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "$YYYY$$MM$$DD$"
(define-fun Witness1 () String (seq.++ "$" (seq.++ "Y" (seq.++ "Y" (seq.++ "Y" (seq.++ "Y" (seq.++ "$" (seq.++ "$" (seq.++ "M" (seq.++ "M" (seq.++ "$" (seq.++ "$" (seq.++ "D" (seq.++ "D" (seq.++ "$" "")))))))))))))))
;witness2: "$YYYY$$MM$$DD$"
(define-fun Witness2 () String (seq.++ "$" (seq.++ "Y" (seq.++ "Y" (seq.++ "Y" (seq.++ "Y" (seq.++ "$" (seq.++ "$" (seq.++ "M" (seq.++ "M" (seq.++ "$" (seq.++ "$" (seq.++ "D" (seq.++ "D" (seq.++ "$" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "$" (seq.++ "Y" (seq.++ "Y" (seq.++ "Y" (seq.++ "Y" (seq.++ "$" (seq.++ "$" (seq.++ "M" (seq.++ "M" (seq.++ "$" (seq.++ "$" (seq.++ "D" (seq.++ "D" (seq.++ "$" ""))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
