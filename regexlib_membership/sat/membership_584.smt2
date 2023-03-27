;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+\d{2}[ \-]{0,1}){0,1}(((\({0,1}[ \-]{0,1})0{0,1}\){0,1}[2|3|7|8]{1}\){0,1}[ \-]*(\d{4}[ \-]{0,1}\d{4}))|(1[ \-]{0,1}(300|800|900|902)[ \-]{0,1}((\d{6})|(\d{3}[ \-]{0,1}\d{3})))|(13[ \-]{0,1}([\d \-]{5})|((\({0,1}[ \-]{0,1})0{0,1}\){0,1}4{1}[\d \-]{8,10})))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+98 1300 909-789"
(define-fun Witness1 () String (str.++ "+" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "1" (str.++ "3" (str.++ "0" (str.++ "0" (str.++ " " (str.++ "9" (str.++ "0" (str.++ "9" (str.++ "-" (str.++ "7" (str.++ "8" (str.++ "9" "")))))))))))))))))
;witness2: "+18(4 -8 -9  "
(define-fun Witness2 () String (str.++ "+" (str.++ "1" (str.++ "8" (str.++ "(" (str.++ "4" (str.++ " " (str.++ "-" (str.++ "8" (str.++ " " (str.++ "-" (str.++ "9" (str.++ " " (str.++ " " ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.range "+" "+")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.union (re.range " " " ") (re.range "-" "-"))))))(re.++ (re.union (re.++ (re.++ (re.opt (re.range "(" "(")) (re.opt (re.union (re.range " " " ") (re.range "-" "-"))))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.union (re.range "2" "3")(re.union (re.range "7" "8") (re.range "|" "|")))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.* (re.union (re.range " " " ") (re.range "-" "-"))) (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))(re.union (re.++ (re.range "1" "1")(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.union (str.to_re (str.++ "3" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "8" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "9" (str.++ "0" (str.++ "0" "")))) (str.to_re (str.++ "9" (str.++ "0" (str.++ "2" "")))))))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) (re.union ((_ re.loop 6 6) (re.range "0" "9")) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 3 3) (re.range "0" "9"))))))))) (re.union (re.++ (str.to_re (str.++ "1" (str.++ "3" "")))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 5 5) (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "0" "9")))))) (re.++ (re.++ (re.opt (re.range "(" "(")) (re.opt (re.union (re.range " " " ") (re.range "-" "-"))))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.range "4" "4") ((_ re.loop 8 10) (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "0" "9"))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
