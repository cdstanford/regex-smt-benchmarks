;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((0[13578]|10|12)([-./])(0[1-9]|[12][0-9]|3[01])([-./])(\d{4}))|((0[469]|11)([-./])([0][1-9]|[12][0-9]|30)([-./])(\d{4}))|((2)([-./])(0[1-9]|1[0-9]|2[0-8])([-./])(\d{4}))|((2)(\.|-|\/)(29)([-./])([02468][048]00))|((2)([-./])(29)([-./])([13579][26]00))|((2)([-./])(29)([-./])([0-9][0-9][0][48]))|((2)([-./])(29)([-./])([0-9][0-9][2468][048]))|((2)([-./])(29)([-./])([0-9][0-9][13579][26])))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "e2/29.4000"
(define-fun Witness1 () String (str.++ "e" (str.++ "2" (str.++ "/" (str.++ "2" (str.++ "9" (str.++ "." (str.++ "4" (str.++ "0" (str.++ "0" (str.++ "0" "")))))))))))
;witness2: "P.\u00D511-29-1943\u00CB"
(define-fun Witness2 () String (str.++ "P" (str.++ "." (str.++ "\u{d5}" (str.++ "1" (str.++ "1" (str.++ "-" (str.++ "2" (str.++ "9" (str.++ "-" (str.++ "1" (str.++ "9" (str.++ "4" (str.++ "3" (str.++ "\u{cb}" "")))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))))(re.union (str.to_re (str.++ "1" (str.++ "0" ""))) (str.to_re (str.++ "1" (str.++ "2" "")))))(re.++ (re.range "-" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "-" "/") ((_ re.loop 4 4) (re.range "0" "9"))))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.range "-" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))(re.++ (re.range "-" "/") ((_ re.loop 4 4) (re.range "0" "9"))))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "-" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))(re.++ (re.range "-" "/") ((_ re.loop 4 4) (re.range "0" "9"))))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "-" "/")(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.range "-" "/") (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))))(re.++ (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))) (str.to_re (str.++ "0" (str.++ "0" "")))))))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "-" "/")(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.range "-" "/") (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))))(re.++ (re.union (re.range "2" "2") (re.range "6" "6")) (str.to_re (str.++ "0" (str.++ "0" "")))))))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "-" "/")(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.range "-" "/") (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))))))))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "-" "/")(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.range "-" "/") (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))))))))) (re.++ (re.range "2" "2")(re.++ (re.range "-" "/")(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.range "-" "/") (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
