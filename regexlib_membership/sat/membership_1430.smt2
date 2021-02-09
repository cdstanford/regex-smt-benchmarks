;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \u00A5
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A5\u00F7\u00A4"
(define-fun Witness1 () String (seq.++ "\xa5" (seq.++ "\xf7" (seq.++ "\xa4" ""))))
;witness2: "\u00A5"
(define-fun Witness2 () String (seq.++ "\xa5" ""))

(assert (= regexA (re.range "\xa5" "\xa5")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
