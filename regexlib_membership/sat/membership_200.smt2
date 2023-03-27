;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "([^\\"]|\\.)*"
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x13\"\""
(define-fun Witness1 () String (str.++ "\u{13}" (str.++ "\u{22}" (str.++ "\u{22}" ""))))
;witness2: "9\"\\u00D9\u0095\u0089\:\\u00F3q\""
(define-fun Witness2 () String (str.++ "9" (str.++ "\u{22}" (str.++ "\u{5c}" (str.++ "\u{d9}" (str.++ "\u{95}" (str.++ "\u{89}" (str.++ "\u{5c}" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{f3}" (str.++ "q" (str.++ "\u{22}" "")))))))))))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "!")(re.union (re.range "#" "[") (re.range "]" "\u{ff}"))) (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (re.range "\u{22}" "\u{22}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
