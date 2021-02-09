;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<local1300>^1300[ |\-]{0,1}\d{3}[ |\-]{0,1}\d{3}$)|(?<tollcall>^1900|1902[ |\-]{0,1}\d{3}[ |\-]{0,1}\d{3}$)|(?<freecall>^1800[ |\-]{0,1}\d{3}[ |\-]{0,1}\d{3}$)|(?<standard>^\({0,1}0[2|3|7|8]{1}\){0,1}[ \-]{0,1}\d{4}[ |\-]{0,1}\d{4}$)|(?<international>^\+61[ |\-]{0,1}[2|3|7|8]{1}[ |\-]{0,1}[0-9]{4}[ |\-]{0,1}[0-9]{4}$)|(?<local13>^13\d{4}$)|(?<mobile>^04\d{2,3}\d{6}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1300358643"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "3" (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "5" (seq.++ "8" (seq.++ "6" (seq.++ "4" (seq.++ "3" "")))))))))))
;witness2: "(0|)31999931"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "|" (seq.++ ")" (seq.++ "3" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "1" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "3" (seq.++ "0" (seq.++ "0" "")))))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))(re.union (re.union (re.++ (str.to_re "") (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "0" "")))))) (re.++ (str.to_re (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "2" "")))))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "0" "")))))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ (re.union (re.range "2" "3")(re.union (re.range "7" "8") (re.range "|" "|")))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "+" (seq.++ "6" (seq.++ "1" ""))))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ (re.union (re.range "2" "3")(re.union (re.range "7" "8") (re.range "|" "|")))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "3" "")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "4" "")))(re.++ ((_ re.loop 2 3) (re.range "0" "9"))(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
