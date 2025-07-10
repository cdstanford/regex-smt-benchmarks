;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*\(?((\+0?44)?\)?[ \-]?(\(0\))|0)((20[7,8]{1}\)?[ \-]?[1-9]{1}[0-9]{2}[ \-]?[0-9]{4})|([1-8]{1}[0-9]{3}\)?[ \-]?[1-9]{1}[0-9]{2}[ \-]?[0-9]{3}))\s*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+044(0)1619)-599 087"
(define-fun Witness1 () String (str.++ "+" (str.++ "0" (str.++ "4" (str.++ "4" (str.++ "(" (str.++ "0" (str.++ ")" (str.++ "1" (str.++ "6" (str.++ "1" (str.++ "9" (str.++ ")" (str.++ "-" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "0" (str.++ "8" (str.++ "7" "")))))))))))))))))))))
;witness2: "\u0085 )(0)8089)286086\u0085"
(define-fun Witness2 () String (str.++ "\u{85}" (str.++ " " (str.++ ")" (str.++ "(" (str.++ "0" (str.++ ")" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ ")" (str.++ "2" (str.++ "8" (str.++ "6" (str.++ "0" (str.++ "8" (str.++ "6" (str.++ "\u{85}" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.union (re.++ (re.opt (re.++ (re.range "+" "+")(re.++ (re.opt (re.range "0" "0")) (str.to_re (str.++ "4" (str.++ "4" ""))))))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) (str.to_re (str.++ "(" (str.++ "0" (str.++ ")" ""))))))) (re.range "0" "0"))(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "0" "")))(re.++ (re.union (re.range "," ",") (re.range "7" "8"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (re.++ (re.range "1" "8")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 3 3) (re.range "0" "9"))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
