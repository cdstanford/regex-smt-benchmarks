;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Expressão regular para Telefones do Brasil.
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0096\u00C2Express\u00E3o regular para Telefones do Brasil1}f\u0080"
(define-fun Witness1 () String (seq.++ "\x96" (seq.++ "\xc2" (seq.++ "E" (seq.++ "x" (seq.++ "p" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ "\xe3" (seq.++ "o" (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "u" (seq.++ "l" (seq.++ "a" (seq.++ "r" (seq.++ " " (seq.++ "p" (seq.++ "a" (seq.++ "r" (seq.++ "a" (seq.++ " " (seq.++ "T" (seq.++ "e" (seq.++ "l" (seq.++ "e" (seq.++ "f" (seq.++ "o" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "d" (seq.++ "o" (seq.++ " " (seq.++ "B" (seq.++ "r" (seq.++ "a" (seq.++ "s" (seq.++ "i" (seq.++ "l" (seq.++ "1" (seq.++ "}" (seq.++ "f" (seq.++ "\x80" "")))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "Express\u00E3o regular para Telefones do Brasil\x1F"
(define-fun Witness2 () String (seq.++ "E" (seq.++ "x" (seq.++ "p" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ "\xe3" (seq.++ "o" (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "u" (seq.++ "l" (seq.++ "a" (seq.++ "r" (seq.++ " " (seq.++ "p" (seq.++ "a" (seq.++ "r" (seq.++ "a" (seq.++ " " (seq.++ "T" (seq.++ "e" (seq.++ "l" (seq.++ "e" (seq.++ "f" (seq.++ "o" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "d" (seq.++ "o" (seq.++ " " (seq.++ "B" (seq.++ "r" (seq.++ "a" (seq.++ "s" (seq.++ "i" (seq.++ "l" (seq.++ "\x1f" ""))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "E" (seq.++ "x" (seq.++ "p" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ "\xe3" (seq.++ "o" (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "u" (seq.++ "l" (seq.++ "a" (seq.++ "r" (seq.++ " " (seq.++ "p" (seq.++ "a" (seq.++ "r" (seq.++ "a" (seq.++ " " (seq.++ "T" (seq.++ "e" (seq.++ "l" (seq.++ "e" (seq.++ "f" (seq.++ "o" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "d" (seq.++ "o" (seq.++ " " (seq.++ "B" (seq.++ "r" (seq.++ "a" (seq.++ "s" (seq.++ "i" (seq.++ "l" ""))))))))))))))))))))))))))))))))))))))))))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
