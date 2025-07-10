;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^\s]+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "}"
(define-fun Witness1 () String (str.++ "}" ""))
;witness2: "e\u008B"
(define-fun Witness2 () String (str.++ "e" (str.++ "\u{8b}" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
