;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((19|20)(([0][48])|([2468][048])|([13579][26]))|2000)[\-](([0][13578]|[1][02])[\-]([012][0-9]|[3][01])|([0][469]|11)[\-]([012][0-9]|30)|02[\-]([012][0-9]))|((19|20)(([02468][1235679])|([13579][01345789]))|1900)[\-](([0][13578]|[1][02])[\-]([012][0-9]|[3][01])|([0][469]|11)[\-]([012][0-9]|30)|02[\-]([012][0-8])))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1964-02-29"
(define-fun Witness1 () String (str.++ "1" (str.++ "9" (str.++ "6" (str.++ "4" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "2" (str.++ "9" "")))))))))))
;witness2: "2081-02-23"
(define-fun Witness2 () String (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "2" (str.++ "3" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (str.to_re (str.++ "2" (str.++ "0" "")))) (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))) (str.to_re (str.++ "2" (str.++ "0" (str.++ "0" (str.++ "0" ""))))))(re.++ (re.range "-" "-") (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))) (re.++ (str.to_re (str.++ "0" (str.++ "2" (str.++ "-" "")))) (re.++ (re.range "0" "2") (re.range "0" "9"))))))) (re.++ (re.union (re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (str.to_re (str.++ "2" (str.++ "0" "")))) (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "1" "3")(re.union (re.range "5" "7") (re.range "9" "9")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "0" "1")(re.union (re.range "3" "5") (re.range "7" "9")))))) (str.to_re (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "0" ""))))))(re.++ (re.range "-" "-") (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))) (re.++ (str.to_re (str.++ "0" (str.++ "2" (str.++ "-" "")))) (re.++ (re.range "0" "2") (re.range "0" "8")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
