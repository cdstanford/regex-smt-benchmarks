;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \u00A5
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A5\u00F7\u00A4"
(define-fun Witness1 () String (str.++ "\u{a5}" (str.++ "\u{f7}" (str.++ "\u{a4}" ""))))
;witness2: "\u00A5"
(define-fun Witness2 () String (str.++ "\u{a5}" ""))

(assert (= regexA (re.range "\u{a5}" "\u{a5}")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
