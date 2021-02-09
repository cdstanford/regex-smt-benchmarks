;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = www.runescape-money.eu
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "www\u00BErunescape-moneyHeu\u00C5!"
(define-fun Witness1 () String (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "\xbe" (seq.++ "r" (seq.++ "u" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ "c" (seq.++ "a" (seq.++ "p" (seq.++ "e" (seq.++ "-" (seq.++ "m" (seq.++ "o" (seq.++ "n" (seq.++ "e" (seq.++ "y" (seq.++ "H" (seq.++ "e" (seq.++ "u" (seq.++ "\xc5" (seq.++ "!" "")))))))))))))))))))))))))
;witness2: "\u00C5\u00B9www)runescape-money\u00D3eu"
(define-fun Witness2 () String (seq.++ "\xc5" (seq.++ "\xb9" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ ")" (seq.++ "r" (seq.++ "u" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ "c" (seq.++ "a" (seq.++ "p" (seq.++ "e" (seq.++ "-" (seq.++ "m" (seq.++ "o" (seq.++ "n" (seq.++ "e" (seq.++ "y" (seq.++ "\xd3" (seq.++ "e" (seq.++ "u" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" ""))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "r" (seq.++ "u" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ "c" (seq.++ "a" (seq.++ "p" (seq.++ "e" (seq.++ "-" (seq.++ "m" (seq.++ "o" (seq.++ "n" (seq.++ "e" (seq.++ "y" ""))))))))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "e" (seq.++ "u" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
