;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <\?xml.*</note>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x1B.<?xml</note>\x10\xF"
(define-fun Witness1 () String (str.++ "\u{1b}" (str.++ "." (str.++ "<" (str.++ "?" (str.++ "x" (str.++ "m" (str.++ "l" (str.++ "<" (str.++ "/" (str.++ "n" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" (str.++ "\u{10}" (str.++ "\u{0f}" "")))))))))))))))))
;witness2: "]\u0094<?xml\x13O</note>"
(define-fun Witness2 () String (str.++ "]" (str.++ "\u{94}" (str.++ "<" (str.++ "?" (str.++ "x" (str.++ "m" (str.++ "l" (str.++ "\u{13}" (str.++ "O" (str.++ "<" (str.++ "/" (str.++ "n" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "?" (str.++ "x" (str.++ "m" (str.++ "l" ""))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re (str.++ "<" (str.++ "/" (str.++ "n" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ ">" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
