;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((^(10|12|0?[13578])(3[01]|[12][0-9]|0?[1-9])((1[8-9]\d{2})|([2-9]\d{3}))$)|(^(11|0?[469])(30|[12][0-9]|0?[1-9])((1[8-9]\d{2})|([2-9]\d{3}))$)|(^(0?2)(2[0-8]|1[0-9]|0?[1-9])((1[8-9]\d{2})|([2-9]\d{3}))$)|(^(0?2)(29)([2468][048]00)$)|(^(0?2)(29)([3579][26]00)$)|(^(0?2)(29)([1][89][0][48])$)|(^(0?2)(29)([2-9][0-9][0][48])$)|(^(0?2)(29)([1][89][2468][048])$)|(^(0?2)(29)([2-9][0-9][2468][048])$)|(^(0?2)(29)([1][89][13579][26])$)|(^(0?2)(29)([2-9][0-9][13579][26])$))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "01051998"
(define-fun Witness1 () String (str.++ "0" (str.++ "1" (str.++ "0" (str.++ "5" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "8" "")))))))))
;witness2: "933288"
(define-fun Witness2 () String (str.++ "9" (str.++ "3" (str.++ "3" (str.++ "2" (str.++ "8" (str.++ "8" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "1" (str.++ "0" "")))(re.union (str.to_re (str.++ "1" (str.++ "2" ""))) (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))))))(re.++ (re.union (re.++ (re.range "3" "3") (re.range "0" "1"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))))(re.++ (re.union (re.++ (re.range "1" "1")(re.++ (re.range "8" "9") ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "1" (str.++ "1" ""))) (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.union (str.to_re (str.++ "3" (str.++ "0" "")))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))))(re.++ (re.union (re.++ (re.range "1" "1")(re.++ (re.range "8" "9") ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "8"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))))(re.++ (re.union (re.++ (re.range "1" "1")(re.++ (re.range "8" "9") ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))(re.++ (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))) (str.to_re (str.++ "0" (str.++ "0" ""))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.++ (re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))(re.++ (re.union (re.range "2" "2") (re.range "6" "6")) (str.to_re (str.++ "0" (str.++ "0" ""))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.++ (re.range "1" "1")(re.++ (re.range "8" "9")(re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8"))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.++ (re.range "2" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8"))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.++ (re.range "1" "1")(re.++ (re.range "8" "9")(re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.++ (re.range "2" "9")(re.++ (re.range "0" "9")(re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.++ (re.range "1" "1")(re.++ (re.range "8" "9")(re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0")) (re.range "2" "2"))(re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.++ (re.range "2" "9")(re.++ (re.range "0" "9")(re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
