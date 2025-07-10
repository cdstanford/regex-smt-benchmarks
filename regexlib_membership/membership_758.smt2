;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (private|public|protected)\s\w(.)*\((.)*\)[^;]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "public\u00A0z()\u00F9"
(define-fun Witness1 () String (str.++ "p" (str.++ "u" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "\u{a0}" (str.++ "z" (str.++ "(" (str.++ ")" (str.++ "\u{f9}" ""))))))))))))
;witness2: "0\u009Dprivate 0\x1A(\u00B3\u0080E)\u00DA"
(define-fun Witness2 () String (str.++ "0" (str.++ "\u{9d}" (str.++ "p" (str.++ "r" (str.++ "i" (str.++ "v" (str.++ "a" (str.++ "t" (str.++ "e" (str.++ " " (str.++ "0" (str.++ "\u{1a}" (str.++ "(" (str.++ "\u{b3}" (str.++ "\u{80}" (str.++ "E" (str.++ ")" (str.++ "\u{da}" "")))))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "p" (str.++ "r" (str.++ "i" (str.++ "v" (str.++ "a" (str.++ "t" (str.++ "e" ""))))))))(re.union (str.to_re (str.++ "p" (str.++ "u" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "c" ""))))))) (str.to_re (str.++ "p" (str.++ "r" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ "c" (str.++ "t" (str.++ "e" (str.++ "d" ""))))))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "(" "(")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range ")" ")") (re.union (re.range "\u{00}" ":") (re.range "<" "\u{ff}")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
