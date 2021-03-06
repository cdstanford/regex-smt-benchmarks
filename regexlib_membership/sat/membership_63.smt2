;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{6}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "399858"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "5" (seq.++ "8" "")))))))
;witness2: "\x19\u00D2189998\xD\u0094\u00FE"
(define-fun Witness2 () String (seq.++ "\x19" (seq.++ "\xd2" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "\x0d" (seq.++ "\x94" (seq.++ "\xfe" ""))))))))))))

(assert (= regexA ((_ re.loop 6 6) (re.range "0" "9"))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
