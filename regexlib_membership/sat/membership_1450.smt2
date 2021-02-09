;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \xA9
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A9UC"
(define-fun Witness1 () String (seq.++ "\xa9" (seq.++ "U" (seq.++ "C" ""))))
;witness2: "\u00A9\x14"
(define-fun Witness2 () String (seq.++ "\xa9" (seq.++ "\x14" "")))

(assert (= regexA (re.range "\xa9" "\xa9")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
