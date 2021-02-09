;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \u00AE
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E9\u00AE"
(define-fun Witness1 () String (seq.++ "\xe9" (seq.++ "\xae" "")))
;witness2: "\x13\x56\u00AE"
(define-fun Witness2 () String (seq.++ "\x13" (seq.++ "\x05" (seq.++ "6" (seq.++ "\xae" "")))))

(assert (= regexA (re.range "\xae" "\xae")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
