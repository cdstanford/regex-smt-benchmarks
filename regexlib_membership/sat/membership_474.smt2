;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 3
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3\x15"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "\x15" "")))
;witness2: "3"
(define-fun Witness2 () String (seq.++ "3" ""))

(assert (= regexA (re.range "3" "3")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
