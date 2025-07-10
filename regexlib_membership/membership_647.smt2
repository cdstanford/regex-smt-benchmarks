;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(Op(.|us))(\s)[1-9](\d)*((,)?(\s)N(o.|um(.|ber))\s[1-9](\d)*)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Op,\xB8,\x9No8\u00858"
(define-fun Witness1 () String (str.++ "O" (str.++ "p" (str.++ "," (str.++ "\u{0b}" (str.++ "8" (str.++ "," (str.++ "\u{09}" (str.++ "N" (str.++ "o" (str.++ "8" (str.++ "\u{85}" (str.++ "8" "")))))))))))))
;witness2: "Opus\u008558"
(define-fun Witness2 () String (str.++ "O" (str.++ "p" (str.++ "u" (str.++ "s" (str.++ "\u{85}" (str.++ "5" (str.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (str.++ "O" (str.++ "p" ""))) (re.union (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "u" (str.++ "s" "")))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "1" "9")(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.range "," ","))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "N" "N")(re.++ (re.union (re.++ (re.range "o" "o") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.++ (str.to_re (str.++ "u" (str.++ "m" ""))) (re.union (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "b" (str.++ "e" (str.++ "r" "")))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "1" "9") (re.* (re.range "0" "9"))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
