;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((\+?64\s*[-\.]?[3-9]|\(?0[3-9]\)?)\s*[-\.]?\d{3}\s*[-\.]?\d{4})|((\+?64\s*[-\.\(]?2\d{1}[-\.\)]?|\(?02\d{1}\)?)\s*[-\.]?\d{3}\s*[-\.]?\d{3,5})|((\+?64\s*[-\.]?[-\.\(]?800[-\.\)]?|[-\.\(]?0800[-\.\)]?)\s*[-\.]?\d{3}\s*[-\.]?(\d{2}|\d{5})))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+64(800) 57639"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "6" (seq.++ "4" (seq.++ "(" (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ ")" (seq.++ " " (seq.++ "5" (seq.++ "7" (seq.++ "6" (seq.++ "3" (seq.++ "9" "")))))))))))))))
;witness2: "64\u00A0\x9800.98419859"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "4" (seq.++ "\xa0" (seq.++ "\x09" (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ "." (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "5" (seq.++ "9" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (seq.++ "6" (seq.++ "4" "")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" ".")) (re.range "3" "9"))))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ (re.range "3" "9") (re.opt (re.range ")" ")"))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "."))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" ".")) ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (seq.++ "6" (seq.++ "4" "")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.union (re.range "(" "(") (re.range "-" ".")))(re.++ (re.range "2" "2")(re.++ (re.range "0" "9") (re.opt (re.union (re.range ")" ")") (re.range "-" "."))))))))) (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.++ (re.range "0" "9") (re.opt (re.range ")" ")"))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "."))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" ".")) ((_ re.loop 3 5) (re.range "0" "9")))))))) (re.++ (re.union (re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (seq.++ "6" (seq.++ "4" "")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "."))(re.++ (re.opt (re.union (re.range "(" "(") (re.range "-" ".")))(re.++ (str.to_re (seq.++ "8" (seq.++ "0" (seq.++ "0" "")))) (re.opt (re.union (re.range ")" ")") (re.range "-" "."))))))))) (re.++ (re.opt (re.union (re.range "(" "(") (re.range "-" ".")))(re.++ (str.to_re (seq.++ "0" (seq.++ "8" (seq.++ "0" (seq.++ "0" ""))))) (re.opt (re.union (re.range ")" ")") (re.range "-" "."))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "."))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" ".")) (re.union ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 5 5) (re.range "0" "9"))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
