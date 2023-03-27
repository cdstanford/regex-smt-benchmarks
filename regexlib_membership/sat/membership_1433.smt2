;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \u00AE
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E9\u00AE"
(define-fun Witness1 () String (str.++ "\u{e9}" (str.++ "\u{ae}" "")))
;witness2: "\x13\x56\u00AE"
(define-fun Witness2 () String (str.++ "\u{13}" (str.++ "\u{05}" (str.++ "6" (str.++ "\u{ae}" "")))))

(assert (= regexA (re.range "\u{ae}" "\u{ae}")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
