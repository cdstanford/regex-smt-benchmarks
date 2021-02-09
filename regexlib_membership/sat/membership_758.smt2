;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (private|public|protected)\s\w(.)*\((.)*\)[^;]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "public\u00A0z()\u00F9"
(define-fun Witness1 () String (seq.++ "p" (seq.++ "u" (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "c" (seq.++ "\xa0" (seq.++ "z" (seq.++ "(" (seq.++ ")" (seq.++ "\xf9" ""))))))))))))
;witness2: "0\u009Dprivate 0\x1A(\u00B3\u0080E)\u00DA"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "\x9d" (seq.++ "p" (seq.++ "r" (seq.++ "i" (seq.++ "v" (seq.++ "a" (seq.++ "t" (seq.++ "e" (seq.++ " " (seq.++ "0" (seq.++ "\x1a" (seq.++ "(" (seq.++ "\xb3" (seq.++ "\x80" (seq.++ "E" (seq.++ ")" (seq.++ "\xda" "")))))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "p" (seq.++ "r" (seq.++ "i" (seq.++ "v" (seq.++ "a" (seq.++ "t" (seq.++ "e" ""))))))))(re.union (str.to_re (seq.++ "p" (seq.++ "u" (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "c" ""))))))) (str.to_re (seq.++ "p" (seq.++ "r" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ "c" (seq.++ "t" (seq.++ "e" (seq.++ "d" ""))))))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "(" "(")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range ")" ")") (re.union (re.range "\x00" ":") (re.range "<" "\xff")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
