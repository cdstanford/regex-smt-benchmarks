;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\+44\s?\(0\)\s?\d{2,4})|(\+44\s?(01|02|03|07|08)\d{2,3})|(\+44\s?(1|2|3|7|8)\d{2,3})|(\(\+44\)\s?\d{3,4})|(\(\d{5}\))|((01|02|03|07|08)\d{2,3})|(\d{5}))(\s|-|.)(((\d{3,4})(\s|-)(\d{3,4}))|((\d{6,7})))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(29999)\u00DF7798972"
(define-fun Witness1 () String (str.++ "(" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ ")" (str.++ "\u{df}" (str.++ "7" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "2" ""))))))))))))))))
;witness2: "+447989Q2966\x99498\u00C2"
(define-fun Witness2 () String (str.++ "+" (str.++ "4" (str.++ "4" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "Q" (str.++ "2" (str.++ "9" (str.++ "6" (str.++ "6" (str.++ "\u{09}" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "\u{c2}" "")))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (str.++ "+" (str.++ "4" (str.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "(" (str.++ "0" (str.++ ")" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 2 4) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "+" (str.++ "4" (str.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (str.to_re (str.++ "0" (str.++ "1" "")))(re.union (str.to_re (str.++ "0" (str.++ "2" "")))(re.union (str.to_re (str.++ "0" (str.++ "3" "")))(re.union (str.to_re (str.++ "0" (str.++ "7" ""))) (str.to_re (str.++ "0" (str.++ "8" ""))))))) ((_ re.loop 2 3) (re.range "0" "9")))))(re.union (re.++ (str.to_re (str.++ "+" (str.++ "4" (str.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.range "1" "3") (re.range "7" "8")) ((_ re.loop 2 3) (re.range "0" "9")))))(re.union (re.++ (str.to_re (str.++ "(" (str.++ "+" (str.++ "4" (str.++ "4" (str.++ ")" ""))))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 3 4) (re.range "0" "9"))))(re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (re.range ")" ")")))(re.union (re.++ (re.union (str.to_re (str.++ "0" (str.++ "1" "")))(re.union (str.to_re (str.++ "0" (str.++ "2" "")))(re.union (str.to_re (str.++ "0" (str.++ "3" "")))(re.union (str.to_re (str.++ "0" (str.++ "7" ""))) (str.to_re (str.++ "0" (str.++ "8" ""))))))) ((_ re.loop 2 3) (re.range "0" "9"))) ((_ re.loop 5 5) (re.range "0" "9"))))))))(re.++ (re.union (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 3 4) (re.range "0" "9")))) ((_ re.loop 6 7) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
