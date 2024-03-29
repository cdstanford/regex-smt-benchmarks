;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([sS][r-tR-Tx-zX-Z])\s*([sx-zSX-Z])?\s*([a-zA-Z]{2,3}))?\s*(\d\d)\s*-?\s*(\d{6,7}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xD\xB\u008502-769932"
(define-fun Witness1 () String (str.++ "\u{0d}" (str.++ "\u{0b}" (str.++ "\u{85}" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "7" (str.++ "6" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "2" "")))))))))))))
;witness2: "SzsoJO\xD68\u00A0\u00A0795880"
(define-fun Witness2 () String (str.++ "S" (str.++ "z" (str.++ "s" (str.++ "o" (str.++ "J" (str.++ "O" (str.++ "\u{0d}" (str.++ "6" (str.++ "8" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "7" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "0" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.++ (re.++ (re.union (re.range "S" "S") (re.range "s" "s")) (re.union (re.range "R" "T")(re.union (re.range "X" "Z")(re.union (re.range "r" "t") (re.range "x" "z")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.union (re.range "S" "S")(re.union (re.range "X" "Z")(re.union (re.range "s" "s") (re.range "x" "z")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ (re.range "0" "9") (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 6 7) (re.range "0" "9")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
