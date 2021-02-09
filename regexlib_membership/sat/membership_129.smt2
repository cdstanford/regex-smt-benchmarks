;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\+44\s?\(0\)\s?\d{2,4})|(\+44\s?(01|02|03|07|08)\d{2,3})|(\+44\s?(1|2|3|7|8)\d{2,3})|(\(\+44\)\s?\d{3,4})|(\(\d{5}\))|((01|02|03|07|08)\d{2,3})|(\d{5}))(\s|-|.)(((\d{3,4})(\s|-)(\d{3,4}))|((\d{6,7})))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(29999)\u00DF7798972"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ ")" (seq.++ "\xdf" (seq.++ "7" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "2" ""))))))))))))))))
;witness2: "+447989Q2966\x99498\u00C2"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "Q" (seq.++ "2" (seq.++ "9" (seq.++ "6" (seq.++ "6" (seq.++ "\x09" (seq.++ "9" (seq.++ "4" (seq.++ "9" (seq.++ "8" (seq.++ "\xc2" "")))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "(" (seq.++ "0" (seq.++ ")" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 2 4) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "1" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "3" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "7" ""))) (str.to_re (seq.++ "0" (seq.++ "8" ""))))))) ((_ re.loop 2 3) (re.range "0" "9")))))(re.union (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "1" "3") (re.range "7" "8")) ((_ re.loop 2 3) (re.range "0" "9")))))(re.union (re.++ (str.to_re (seq.++ "(" (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ ")" ""))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 4) (re.range "0" "9"))))(re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (re.range ")" ")")))(re.union (re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "1" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "3" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "7" ""))) (str.to_re (seq.++ "0" (seq.++ "8" ""))))))) ((_ re.loop 2 3) (re.range "0" "9"))) ((_ re.loop 5 5) (re.range "0" "9"))))))))(re.++ (re.union (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 4) (re.range "0" "9")))) ((_ re.loop 6 7) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
