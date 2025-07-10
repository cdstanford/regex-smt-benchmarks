;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\x80-\xFF]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u009B\u00EA"
(define-fun Witness1 () String (str.++ "\u{9b}" (str.++ "\u{ea}" "")))
;witness2: "\u00BF"
(define-fun Witness2 () String (str.++ "\u{bf}" ""))

(assert (= regexA (re.range "\u{80}" "\u{ff}")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
