;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = test
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "test"
(define-fun Witness1 () String (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "t" "")))))
;witness2: "test\u008E\u0094\u00AC\u00DE\u00AA\u00D2"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "t" (seq.++ "\x8e" (seq.++ "\x94" (seq.++ "\xac" (seq.++ "\xde" (seq.++ "\xaa" (seq.++ "\xd2" "")))))))))))

(assert (= regexA (str.to_re (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "t" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
