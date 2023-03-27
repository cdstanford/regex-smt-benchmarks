;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((Fred|Wilma)\s+Flintstone|(Barney|Betty)\s+Rubble)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Wilma\u0085\u0085\u00A0Flintstone"
(define-fun Witness1 () String (str.++ "W" (str.++ "i" (str.++ "l" (str.++ "m" (str.++ "a" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "F" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "t" (str.++ "s" (str.++ "t" (str.++ "o" (str.++ "n" (str.++ "e" "")))))))))))))))))))
;witness2: "Fred\xBFlintstone"
(define-fun Witness2 () String (str.++ "F" (str.++ "r" (str.++ "e" (str.++ "d" (str.++ "\u{0b}" (str.++ "F" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "t" (str.++ "s" (str.++ "t" (str.++ "o" (str.++ "n" (str.++ "e" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (str.to_re (str.++ "F" (str.++ "r" (str.++ "e" (str.++ "d" ""))))) (str.to_re (str.++ "W" (str.++ "i" (str.++ "l" (str.++ "m" (str.++ "a" "")))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re (str.++ "F" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "t" (str.++ "s" (str.++ "t" (str.++ "o" (str.++ "n" (str.++ "e" ""))))))))))))) (re.++ (re.union (str.to_re (str.++ "B" (str.++ "a" (str.++ "r" (str.++ "n" (str.++ "e" (str.++ "y" ""))))))) (str.to_re (str.++ "B" (str.++ "e" (str.++ "t" (str.++ "t" (str.++ "y" "")))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re (str.++ "R" (str.++ "u" (str.++ "b" (str.++ "b" (str.++ "l" (str.++ "e" "")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
