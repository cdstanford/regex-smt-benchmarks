;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = df
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "df"
(define-fun Witness1 () String (seq.++ "d" (seq.++ "f" "")))
;witness2: "L\u0083f\u00C7df`"
(define-fun Witness2 () String (seq.++ "L" (seq.++ "\x83" (seq.++ "f" (seq.++ "\xc7" (seq.++ "d" (seq.++ "f" (seq.++ "`" ""))))))))

(assert (= regexA (str.to_re (seq.++ "d" (seq.++ "f" "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
