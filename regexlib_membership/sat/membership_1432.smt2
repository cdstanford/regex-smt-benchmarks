;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \u00A3
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00CBt\u00A3\u008E\"
(define-fun Witness1 () String (str.++ "\u{cb}" (str.++ "t" (str.++ "\u{a3}" (str.++ "\u{8e}" (str.++ "\u{5c}" ""))))))
;witness2: "x\u00A3\u00E5\u009D\x4"
(define-fun Witness2 () String (str.++ "x" (str.++ "\u{a3}" (str.++ "\u{e5}" (str.++ "\u{9d}" (str.++ "\u{04}" ""))))))

(assert (= regexA (re.range "\u{a3}" "\u{a3}")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
