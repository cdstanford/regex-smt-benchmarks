;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \+353\(0\)\s\d\s\d{3}\s\d{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "&+353(0)\u00858\u00A0857\u00859890lhF$\u00FF"
(define-fun Witness1 () String (str.++ "&" (str.++ "+" (str.++ "3" (str.++ "5" (str.++ "3" (str.++ "(" (str.++ "0" (str.++ ")" (str.++ "\u{85}" (str.++ "8" (str.++ "\u{a0}" (str.++ "8" (str.++ "5" (str.++ "7" (str.++ "\u{85}" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "l" (str.++ "h" (str.++ "F" (str.++ "$" (str.++ "\u{ff}" "")))))))))))))))))))))))))
;witness2: "\u00A7+353(0)\xA5\u0085081\u00859989"
(define-fun Witness2 () String (str.++ "\u{a7}" (str.++ "+" (str.++ "3" (str.++ "5" (str.++ "3" (str.++ "(" (str.++ "0" (str.++ ")" (str.++ "\u{0a}" (str.++ "5" (str.++ "\u{85}" (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "\u{85}" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "+" (str.++ "3" (str.++ "5" (str.++ "3" (str.++ "(" (str.++ "0" (str.++ ")" ""))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
