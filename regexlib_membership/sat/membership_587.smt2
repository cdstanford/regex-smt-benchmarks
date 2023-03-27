;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<tagname>[^\s]*)="(?<tagvalue>[^"]*)"
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u007F\u00A5=\"*\"\u00F2"
(define-fun Witness1 () String (str.++ "\u{7f}" (str.++ "\u{a5}" (str.++ "=" (str.++ "\u{22}" (str.++ "*" (str.++ "\u{22}" (str.++ "\u{f2}" ""))))))))
;witness2: "\x1Fz\u0095\u00C6=\"\""
(define-fun Witness2 () String (str.++ "\u{1f}" (str.++ "z" (str.++ "\u{95}" (str.++ "\u{c6}" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{22}" ""))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))(re.++ (str.to_re (str.++ "=" (str.++ "\u{22}" "")))(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
