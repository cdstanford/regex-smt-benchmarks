;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = X-Spam-Level:\s[*]{11}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "X-Spam-Level:\u0085***********"
(define-fun Witness1 () String (str.++ "X" (str.++ "-" (str.++ "S" (str.++ "p" (str.++ "a" (str.++ "m" (str.++ "-" (str.++ "L" (str.++ "e" (str.++ "v" (str.++ "e" (str.++ "l" (str.++ ":" (str.++ "\u{85}" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" ""))))))))))))))))))))))))))
;witness2: "X-Spam-Level:\u0085***********\u00DCv"
(define-fun Witness2 () String (str.++ "X" (str.++ "-" (str.++ "S" (str.++ "p" (str.++ "a" (str.++ "m" (str.++ "-" (str.++ "L" (str.++ "e" (str.++ "v" (str.++ "e" (str.++ "l" (str.++ ":" (str.++ "\u{85}" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "*" (str.++ "\u{dc}" (str.++ "v" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "X" (str.++ "-" (str.++ "S" (str.++ "p" (str.++ "a" (str.++ "m" (str.++ "-" (str.++ "L" (str.++ "e" (str.++ "v" (str.++ "e" (str.++ "l" (str.++ ":" ""))))))))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 11 11) (re.range "*" "*"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
