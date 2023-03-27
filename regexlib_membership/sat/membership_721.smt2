;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = www.runescape-money.eu
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "www\u00BErunescape-moneyHeu\u00C5!"
(define-fun Witness1 () String (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "\u{be}" (str.++ "r" (str.++ "u" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ "c" (str.++ "a" (str.++ "p" (str.++ "e" (str.++ "-" (str.++ "m" (str.++ "o" (str.++ "n" (str.++ "e" (str.++ "y" (str.++ "H" (str.++ "e" (str.++ "u" (str.++ "\u{c5}" (str.++ "!" "")))))))))))))))))))))))))
;witness2: "\u00C5\u00B9www)runescape-money\u00D3eu"
(define-fun Witness2 () String (str.++ "\u{c5}" (str.++ "\u{b9}" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ ")" (str.++ "r" (str.++ "u" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ "c" (str.++ "a" (str.++ "p" (str.++ "e" (str.++ "-" (str.++ "m" (str.++ "o" (str.++ "n" (str.++ "e" (str.++ "y" (str.++ "\u{d3}" (str.++ "e" (str.++ "u" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" ""))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "r" (str.++ "u" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ "c" (str.++ "a" (str.++ "p" (str.++ "e" (str.++ "-" (str.++ "m" (str.++ "o" (str.++ "n" (str.++ "e" (str.++ "y" ""))))))))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "e" (str.++ "u" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
