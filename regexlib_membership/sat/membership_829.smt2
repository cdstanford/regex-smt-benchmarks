;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "(\\.|[^"])*"
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ",\"\"^"
(define-fun Witness1 () String (str.++ "," (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "^" "")))))
;witness2: "\u00EE1\x15,\"\s\\u00C0\2\1i\""
(define-fun Witness2 () String (str.++ "\u{ee}" (str.++ "1" (str.++ "\u{15}" (str.++ "," (str.++ "\u{22}" (str.++ "\u{5c}" (str.++ "s" (str.++ "\u{5c}" (str.++ "\u{c0}" (str.++ "\u{5c}" (str.++ "2" (str.++ "\u{5c}" (str.++ "1" (str.++ "i" (str.++ "\u{22}" ""))))))))))))))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}")))) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
