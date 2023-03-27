;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((19[0-9][0-9])|(2[0-9][0-9][0-9]))([-])(0[13578]|10|12)([-])(0[1-9]|[12][0-9]|3[01]))|(((19[0-9][0-9])|(2[0-9][0-9][0-9]))([-])(0[469]|11)([-])([0][1-9]|[12][0-9]|30))|(((19[0-9][0-9])|(2[0-9][0-9][0-9]))([-])(02)([-])(0[1-9]|1[0-9]|2[0-8]))|(([02468][048]00)([-])(02)([-])(29))|(([13579][26]00)([-])(02)([-])(29))|(([0-9][0-9][0][48])([-])(02)([-])(29))|(([0-9][0-9][2468][048])([-])(02)([-])(29))|(([0-9][0-9][13579][26])([-])(02)([-])(29)))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1988-02-14"
(define-fun Witness1 () String (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "1" (str.++ "4" "")))))))))))
;witness2: "1957-02-28"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "5" (str.++ "7" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "2" (str.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" "")))(re.++ (re.range "0" "9") (re.range "0" "9"))) (re.++ (re.range "2" "2")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))))(re.union (str.to_re (str.++ "1" (str.++ "0" ""))) (str.to_re (str.++ "1" (str.++ "2" "")))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))))(re.union (re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" "")))(re.++ (re.range "0" "9") (re.range "0" "9"))) (re.++ (re.range "2" "2")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))))))(re.union (re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" "")))(re.++ (re.range "0" "9") (re.range "0" "9"))) (re.++ (re.range "2" "2")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))))(re.++ (re.range "-" "-")(re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))))))(re.union (re.++ (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))))(re.++ (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))) (str.to_re (str.++ "0" (str.++ "0" "")))))(re.++ (re.range "-" "-")(re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "-" "-") (str.to_re (str.++ "2" (str.++ "9" "")))))))(re.union (re.++ (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))))(re.++ (re.union (re.range "2" "2") (re.range "6" "6")) (str.to_re (str.++ "0" (str.++ "0" "")))))(re.++ (re.range "-" "-")(re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "-" "-") (str.to_re (str.++ "2" (str.++ "9" "")))))))(re.union (re.++ (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))))(re.++ (re.range "-" "-")(re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "-" "-") (str.to_re (str.++ "2" (str.++ "9" "")))))))(re.union (re.++ (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))))(re.++ (re.range "-" "-")(re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "-" "-") (str.to_re (str.++ "2" (str.++ "9" ""))))))) (re.++ (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))(re.++ (re.range "-" "-")(re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "-" "-") (str.to_re (str.++ "2" (str.++ "9" "")))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
