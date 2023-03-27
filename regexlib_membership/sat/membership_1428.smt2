;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \p{IsBasicLatin}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Z"
(define-fun Witness1 () String (str.++ "Z" ""))
;witness2: "j\x7"
(define-fun Witness2 () String (str.++ "j" (str.++ "\u{07}" "")))

(assert (= regexA (re.range "\u{00}" "\u{7f}")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
