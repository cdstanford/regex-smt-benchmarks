;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ("((\\.)|[^\\"])*")
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00CF\u00BE,\"\u00C8\x16\""
(define-fun Witness1 () String (str.++ "\u{cf}" (str.++ "\u{be}" (str.++ "," (str.++ "\u{22}" (str.++ "\u{c8}" (str.++ "\u{16}" (str.++ "\u{22}" ""))))))))
;witness2: "\"\u00D0\"1"
(define-fun Witness2 () String (str.++ "\u{22}" (str.++ "\u{d0}" (str.++ "\u{22}" (str.++ "1" "")))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "[") (re.range "]" "\u{ff}"))))) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
