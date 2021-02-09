;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((\+44\s?\d{4}|\(?0\d{4}\)?)\s?\d{3}\s?\d{3})|((\+44\s?\d{3}|\(?0\d{3}\)?)\s?\d{3}\s?\d{4})|((\+44\s?\d{2}|\(?0\d{2}\)?)\s?\d{4}\s?\d{4}))(\s?\#(\d{4}|\d{3}))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+446648\x9598951#7768"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ "6" (seq.++ "6" (seq.++ "4" (seq.++ "8" (seq.++ "\x09" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "1" (seq.++ "#" (seq.++ "7" (seq.++ "7" (seq.++ "6" (seq.++ "8" ""))))))))))))))))))))
;witness2: "(087 9998\u00851326"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "8" (seq.++ "7" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "\x85" (seq.++ "1" (seq.++ "3" (seq.++ "2" (seq.++ "6" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9")))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 3) (re.range "0" "9"))))))(re.union (re.++ (re.union (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 3) (re.range "0" "9")))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9")))))) (re.++ (re.union (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" ""))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.range ")" ")"))))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.++ (re.opt (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "#" "#") (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 3 3) (re.range "0" "9")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
