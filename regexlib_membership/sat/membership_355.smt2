;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\(?\+44\)?\s?(1|2|3|7|8)\d{3}|\(?(01|02|03|07|08)\d{3}\)?)\s?\d{3}\s?\d{3}|(\(?\+44\)?\s?(1|2|3|5|7|8)\d{2}|\(?(01|02|03|05|07|08)\d{2}\)?)\s?\d{3}\s?\d{4}|(\(?\+44\)?\s?(5|9)\d{2}|\(?(05|09)\d{2}\)?)\s?\d{3}\s?\d{3}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+44527488883"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ "5" (seq.++ "2" (seq.++ "7" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "3" "")))))))))))))
;witness2: "(0580) 198\u00A0917"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "5" (seq.++ "8" (seq.++ "0" (seq.++ ")" (seq.++ " " (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "\xa0" (seq.++ "9" (seq.++ "1" (seq.++ "7" "")))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "1" "3") (re.range "7" "8")) ((_ re.loop 3 3) (re.range "0" "9"))))))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "1" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "3" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "7" ""))) (str.to_re (seq.++ "0" (seq.++ "8" "")))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 3) (re.range "0" "9"))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "1" "3")(re.union (re.range "5" "5") (re.range "7" "8"))) ((_ re.loop 2 2) (re.range "0" "9"))))))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "1" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "3" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "5" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "7" ""))) (str.to_re (seq.++ "0" (seq.++ "8" ""))))))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9")))))) (re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "5" "5") (re.range "9" "9")) ((_ re.loop 2 2) (re.range "0" "9"))))))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.union (str.to_re (seq.++ "0" (seq.++ "5" ""))) (str.to_re (seq.++ "0" (seq.++ "9" ""))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 3) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
