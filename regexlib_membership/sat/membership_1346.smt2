;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(19[0-9]{2}|[2-9][0-9]{3})-((0(1|3|5|7|8)|10|12)-(0[1-9]|1[0-9]|2[0-9]|3[0-1])|(0(4|6|9)|11)-(0[1-9]|1[0-9]|2[0-9]|30)|(02)-(0[1-9]|1[0-9]|2[0-9]))\x20(0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]){2}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1913-02-29 20:58:38"
(define-fun Witness1 () String (str.++ "1" (str.++ "9" (str.++ "1" (str.++ "3" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "2" (str.++ "9" (str.++ " " (str.++ "2" (str.++ "0" (str.++ ":" (str.++ "5" (str.++ "8" (str.++ ":" (str.++ "3" (str.++ "8" ""))))))))))))))))))))
;witness2: "1998-11-20 17:37:20"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "1" (str.++ "1" (str.++ "-" (str.++ "2" (str.++ "0" (str.++ " " (str.++ "1" (str.++ "7" (str.++ ":" (str.++ "3" (str.++ "7" (str.++ ":" (str.++ "2" (str.++ "0" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" ""))) ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9"))))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))))(re.union (str.to_re (str.++ "1" (str.++ "0" ""))) (str.to_re (str.++ "1" (str.++ "2" "")))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))))) (re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "9"))))))))(re.++ (re.range " " " ")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ ((_ re.loop 2 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
