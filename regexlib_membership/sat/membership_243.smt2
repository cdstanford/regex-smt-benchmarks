;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0(0(4|8)|1(0|2|6)|2(0|4|8)|3(1|2|6)|4(0|4|8)|5(0|1|2|6)|6(0|4|8)|7(0|2|4|6)|8(4|6)|9(0|2|6))|1(0(0|4|8)|1(2|6)|2(0|4)|3(2|6)|4(0|4|8)|5(2|6)|6(2|6)|7(0|4|5|8)|8(0|4|8)|9(1|2|6))|2(0(3|4|8)|1(2|4|8)|2(2|6)|3(1|2|3|4|8|9)|4(2|4|8)|5(0|4|8)|6(0|2|6|8)|7(0|5|6)|88|9(2|6))|3(0(0|4|8)|1(2|6)|2(0|4|8)|3(2|4|6)|4(0|4|8)|5(2|6)|6(0|4|8)|7(2|6)|8(0|4|8|9)|92)|4(0(0|4|8)|1(0|4|7|8)|2(2|6|8)|3(0|4|8)|4(0|2|6)|5(0|4|8)|6(2|6)|7(0|4|8)|8(0|4)|9(2|6|8|9))|5(0(0|4|8)|1(2|6)|2(0|4|8)|3(0|3)|4(0|8)|5(4|8)|6(2|6)|7(0|4|8)|8(0|1|3|4|5|6)|9(1|8))|6(0(0|4|8)|1(2|6)|2(0|4|6)|3(0|4|8)|4(2|3|6)|5(2|4|9)|6(0|2|3|6)|7(0|4|8)|8(2|6|8)|9(0|4))|7(0(2|3|4|5|6)|1(0|6)|24|3(2|6)|4(0|4|8)|5(2|6)|6(0|4|8)|7(2|6)|8(0|4|8)|9(2|5|6|8))|8(0(0|4|7)|26|3(1|2|3|4)|40|5(0|8)|6(0|2)|76|8(2|7)|94))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "706"
(define-fun Witness1 () String (str.++ "7" (str.++ "0" (str.++ "6" ""))))
;witness2: "826"
(define-fun Witness2 () String (str.++ "8" (str.++ "2" (str.++ "6" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.range "1" "1") (re.union (re.range "0" "0")(re.union (re.range "2" "2") (re.range "6" "6"))))(re.union (re.++ (re.range "2" "2") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "3" "3") (re.union (re.range "1" "2") (re.range "6" "6")))(re.union (re.++ (re.range "4" "4") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "5" "5") (re.union (re.range "0" "2") (re.range "6" "6")))(re.union (re.++ (re.range "6" "6") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "7" "7") (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4") (re.range "6" "6")))))(re.union (re.++ (re.range "8" "8") (re.union (re.range "4" "4") (re.range "6" "6"))) (re.++ (re.range "9" "9") (re.union (re.range "0" "0")(re.union (re.range "2" "2") (re.range "6" "6"))))))))))))))(re.union (re.++ (re.range "1" "1") (re.union (re.++ (re.range "0" "0") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "1" "1") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "2" "2") (re.union (re.range "0" "0") (re.range "4" "4")))(re.union (re.++ (re.range "3" "3") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "4" "4") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "5" "5") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "6" "6") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "7" "7") (re.union (re.range "0" "0")(re.union (re.range "4" "5") (re.range "8" "8"))))(re.union (re.++ (re.range "8" "8") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.range "9" "9") (re.union (re.range "1" "2") (re.range "6" "6")))))))))))))(re.union (re.++ (re.range "2" "2") (re.union (re.++ (re.range "0" "0") (re.union (re.range "3" "4") (re.range "8" "8")))(re.union (re.++ (re.range "1" "1") (re.union (re.range "2" "2")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "2" "2") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "3" "3") (re.union (re.range "1" "4") (re.range "8" "9")))(re.union (re.++ (re.range "4" "4") (re.union (re.range "2" "2")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "5" "5") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "6" "6") (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "6" "6") (re.range "8" "8")))))(re.union (re.++ (re.range "7" "7") (re.union (re.range "0" "0") (re.range "5" "6")))(re.union (str.to_re (str.++ "8" (str.++ "8" ""))) (re.++ (re.range "9" "9") (re.union (re.range "2" "2") (re.range "6" "6")))))))))))))(re.union (re.++ (re.range "3" "3") (re.union (re.++ (re.range "0" "0") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "1" "1") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "2" "2") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "3" "3") (re.union (re.range "2" "2")(re.union (re.range "4" "4") (re.range "6" "6"))))(re.union (re.++ (re.range "4" "4") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "5" "5") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "6" "6") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "7" "7") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "8" "8") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "9")))) (str.to_re (str.++ "9" (str.++ "2" "")))))))))))))(re.union (re.++ (re.range "4" "4") (re.union (re.++ (re.range "0" "0") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "1" "1") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "7" "8"))))(re.union (re.++ (re.range "2" "2") (re.union (re.range "2" "2")(re.union (re.range "6" "6") (re.range "8" "8"))))(re.union (re.++ (re.range "3" "3") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "4" "4") (re.union (re.range "0" "0")(re.union (re.range "2" "2") (re.range "6" "6"))))(re.union (re.++ (re.range "5" "5") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "6" "6") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "7" "7") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "8" "8") (re.union (re.range "0" "0") (re.range "4" "4"))) (re.++ (re.range "9" "9") (re.union (re.range "2" "2")(re.union (re.range "6" "6") (re.range "8" "9"))))))))))))))(re.union (re.++ (re.range "5" "5") (re.union (re.++ (re.range "0" "0") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "1" "1") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "2" "2") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "3" "3") (re.union (re.range "0" "0") (re.range "3" "3")))(re.union (re.++ (re.range "4" "4") (re.union (re.range "0" "0") (re.range "8" "8")))(re.union (re.++ (re.range "5" "5") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.range "6" "6") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "7" "7") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "8" "8") (re.union (re.range "0" "1") (re.range "3" "6"))) (re.++ (re.range "9" "9") (re.union (re.range "1" "1") (re.range "8" "8")))))))))))))(re.union (re.++ (re.range "6" "6") (re.union (re.++ (re.range "0" "0") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "1" "1") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "2" "2") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "6" "6"))))(re.union (re.++ (re.range "3" "3") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "4" "4") (re.union (re.range "2" "3") (re.range "6" "6")))(re.union (re.++ (re.range "5" "5") (re.union (re.range "2" "2")(re.union (re.range "4" "4") (re.range "9" "9"))))(re.union (re.++ (re.range "6" "6") (re.union (re.range "0" "0")(re.union (re.range "2" "3") (re.range "6" "6"))))(re.union (re.++ (re.range "7" "7") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "8" "8") (re.union (re.range "2" "2")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.++ (re.range "9" "9") (re.union (re.range "0" "0") (re.range "4" "4")))))))))))))(re.union (re.++ (re.range "7" "7") (re.union (re.++ (re.range "0" "0") (re.range "2" "6"))(re.union (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "6" "6")))(re.union (str.to_re (str.++ "2" (str.++ "4" "")))(re.union (re.++ (re.range "3" "3") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "4" "4") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "5" "5") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "6" "6") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.range "7" "7") (re.union (re.range "2" "2") (re.range "6" "6")))(re.union (re.++ (re.range "8" "8") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.range "9" "9") (re.union (re.range "2" "2")(re.union (re.range "5" "6") (re.range "8" "8")))))))))))))) (re.++ (re.range "8" "8") (re.union (re.++ (re.range "0" "0") (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "7" "7"))))(re.union (str.to_re (str.++ "2" (str.++ "6" "")))(re.union (re.++ (re.range "3" "3") (re.range "1" "4"))(re.union (str.to_re (str.++ "4" (str.++ "0" "")))(re.union (re.++ (re.range "5" "5") (re.union (re.range "0" "0") (re.range "8" "8")))(re.union (re.++ (re.range "6" "6") (re.union (re.range "0" "0") (re.range "2" "2")))(re.union (str.to_re (str.++ "7" (str.++ "6" "")))(re.union (re.++ (re.range "8" "8") (re.union (re.range "2" "2") (re.range "7" "7"))) (str.to_re (str.++ "9" (str.++ "4" "")))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
