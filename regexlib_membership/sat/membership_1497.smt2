;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\(?0\d{4}\)?\s?\d{3}\s?\d{3})|(\(?0\d{3}\)?\s?\d{3}\s?\d{4})|(\(?0\d{2}\)?\s?\d{4}\s?\d{4}))(\s?\#(\d{4}|\d{3}))?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(09493 673935\u0085#089"
(define-fun Witness1 () String (str.++ "(" (str.++ "0" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "3" (str.++ " " (str.++ "6" (str.++ "7" (str.++ "3" (str.++ "9" (str.++ "3" (str.++ "5" (str.++ "\u{85}" (str.++ "#" (str.++ "0" (str.++ "8" (str.++ "9" "")))))))))))))))))))
;witness2: "0151 1689298"
(define-fun Witness2 () String (str.++ "0" (str.++ "1" (str.++ "5" (str.++ "1" (str.++ " " (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 3 3) (re.range "0" "9")))))))))(re.union (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 4 4) (re.range "0" "9")))))))))))(re.++ (re.opt (re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "#" "#") (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 3 3) (re.range "0" "9")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
