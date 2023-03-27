;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Expressão regular para Telefones do Brasil.
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0096\u00C2Express\u00E3o regular para Telefones do Brasil1}f\u0080"
(define-fun Witness1 () String (str.++ "\u{96}" (str.++ "\u{c2}" (str.++ "E" (str.++ "x" (str.++ "p" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ "\u{e3}" (str.++ "o" (str.++ " " (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "u" (str.++ "l" (str.++ "a" (str.++ "r" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "r" (str.++ "a" (str.++ " " (str.++ "T" (str.++ "e" (str.++ "l" (str.++ "e" (str.++ "f" (str.++ "o" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "d" (str.++ "o" (str.++ " " (str.++ "B" (str.++ "r" (str.++ "a" (str.++ "s" (str.++ "i" (str.++ "l" (str.++ "1" (str.++ "}" (str.++ "f" (str.++ "\u{80}" "")))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "Express\u00E3o regular para Telefones do Brasil\x1F"
(define-fun Witness2 () String (str.++ "E" (str.++ "x" (str.++ "p" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ "\u{e3}" (str.++ "o" (str.++ " " (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "u" (str.++ "l" (str.++ "a" (str.++ "r" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "r" (str.++ "a" (str.++ " " (str.++ "T" (str.++ "e" (str.++ "l" (str.++ "e" (str.++ "f" (str.++ "o" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "d" (str.++ "o" (str.++ " " (str.++ "B" (str.++ "r" (str.++ "a" (str.++ "s" (str.++ "i" (str.++ "l" (str.++ "\u{1f}" ""))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "E" (str.++ "x" (str.++ "p" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ "\u{e3}" (str.++ "o" (str.++ " " (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "u" (str.++ "l" (str.++ "a" (str.++ "r" (str.++ " " (str.++ "p" (str.++ "a" (str.++ "r" (str.++ "a" (str.++ " " (str.++ "T" (str.++ "e" (str.++ "l" (str.++ "e" (str.++ "f" (str.++ "o" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "d" (str.++ "o" (str.++ " " (str.++ "B" (str.++ "r" (str.++ "a" (str.++ "s" (str.++ "i" (str.++ "l" ""))))))))))))))))))))))))))))))))))))))))))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
