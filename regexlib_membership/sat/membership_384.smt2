;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = name.matches("a-z")
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "name\u0094matches\"a-z\""
(define-fun Witness1 () String (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "\u{94}" (str.++ "m" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "e" (str.++ "s" (str.++ "\u{22}" (str.++ "a" (str.++ "-" (str.++ "z" (str.++ "\u{22}" ""))))))))))))))))))
;witness2: "H\u00E5name\x13matches\"a-z\""
(define-fun Witness2 () String (str.++ "H" (str.++ "\u{e5}" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "\u{13}" (str.++ "m" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "e" (str.++ "s" (str.++ "\u{22}" (str.++ "a" (str.++ "-" (str.++ "z" (str.++ "\u{22}" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" "")))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "m" (str.++ "a" (str.++ "t" (str.++ "c" (str.++ "h" (str.++ "e" (str.++ "s" "")))))))) (str.to_re (str.++ "\u{22}" (str.++ "a" (str.++ "-" (str.++ "z" (str.++ "\u{22}" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
