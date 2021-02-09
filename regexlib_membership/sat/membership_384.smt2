;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = name.matches("a-z")
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "name\u0094matches\"a-z\""
(define-fun Witness1 () String (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ "\x94" (seq.++ "m" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "e" (seq.++ "s" (seq.++ "\x22" (seq.++ "a" (seq.++ "-" (seq.++ "z" (seq.++ "\x22" ""))))))))))))))))))
;witness2: "H\u00E5name\x13matches\"a-z\""
(define-fun Witness2 () String (seq.++ "H" (seq.++ "\xe5" (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ "\x13" (seq.++ "m" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "e" (seq.++ "s" (seq.++ "\x22" (seq.++ "a" (seq.++ "-" (seq.++ "z" (seq.++ "\x22" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" "")))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "e" (seq.++ "s" "")))))))) (str.to_re (seq.++ "\x22" (seq.++ "a" (seq.++ "-" (seq.++ "z" (seq.++ "\x22" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
