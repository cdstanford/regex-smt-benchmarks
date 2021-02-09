;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\x80-\xFF]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u009B\u00EA"
(define-fun Witness1 () String (seq.++ "\x9b" (seq.++ "\xea" "")))
;witness2: "\u00BF"
(define-fun Witness2 () String (seq.++ "\xbf" ""))

(assert (= regexA (re.range "\x80" "\xff")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
