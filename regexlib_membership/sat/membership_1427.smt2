;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \p{N}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3\u007F\u00D8\u00AA"
(define-fun Witness1 () String (str.++ "3" (str.++ "\u{7f}" (str.++ "\u{d8}" (str.++ "\u{aa}" "")))))
;witness2: "1C"
(define-fun Witness2 () String (str.++ "1" (str.++ "C" "")))

(assert (= regexA (re.union (re.range "0" "9")(re.union (re.range "\u{b2}" "\u{b3}")(re.union (re.range "\u{b9}" "\u{b9}") (re.range "\u{bc}" "\u{be}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
