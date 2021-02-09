;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*\(?((\+0?44)?\)?[ \-]?(\(0\))|0)((20[7,8]{1}\)?[ \-]?[1-9]{1}[0-9]{2}[ \-]?[0-9]{4})|([1-8]{1}[0-9]{3}\)?[ \-]?[1-9]{1}[0-9]{2}[ \-]?[0-9]{3}))\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+044(0)1619)-599 087"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "0" (seq.++ "4" (seq.++ "4" (seq.++ "(" (seq.++ "0" (seq.++ ")" (seq.++ "1" (seq.++ "6" (seq.++ "1" (seq.++ "9" (seq.++ ")" (seq.++ "-" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "0" (seq.++ "8" (seq.++ "7" "")))))))))))))))))))))
;witness2: "\u0085 )(0)8089)286086\u0085"
(define-fun Witness2 () String (seq.++ "\x85" (seq.++ " " (seq.++ ")" (seq.++ "(" (seq.++ "0" (seq.++ ")" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ ")" (seq.++ "2" (seq.++ "8" (seq.++ "6" (seq.++ "0" (seq.++ "8" (seq.++ "6" (seq.++ "\x85" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.union (re.++ (re.opt (re.++ (re.range "+" "+")(re.++ (re.opt (re.range "0" "0")) (str.to_re (seq.++ "4" (seq.++ "4" ""))))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) (str.to_re (seq.++ "(" (seq.++ "0" (seq.++ ")" ""))))))) (re.range "0" "0"))(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "0" "")))(re.++ (re.union (re.range "," ",") (re.range "7" "8"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (re.++ (re.range "1" "8")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 3 3) (re.range "0" "9"))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
