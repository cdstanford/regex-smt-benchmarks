;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (.|[\r\n]){1,5}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+\u0084E\u00F4Z\u00D2"
(define-fun Witness1 () String (str.++ "+" (str.++ "\u{84}" (str.++ "E" (str.++ "\u{f4}" (str.++ "Z" (str.++ "\u{d2}" "")))))))
;witness2: "\u{11}"
(define-fun Witness2 () String (str.++ "\u{11}" ""))

(assert (= regexA ((_ re.loop 1 5) (re.union (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.union (re.range "\u{0a}" "\u{0a}") (re.range "\u{0d}" "\u{0d}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
