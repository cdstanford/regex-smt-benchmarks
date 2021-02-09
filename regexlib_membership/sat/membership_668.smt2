;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "10/7-6713"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "0" (seq.++ "/" (seq.++ "7" (seq.++ "-" (seq.++ "6" (seq.++ "7" (seq.++ "1" (seq.++ "3" ""))))))))))
;witness2: "8/31-8089"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "/" (seq.++ "3" (seq.++ "1" (seq.++ "-" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "9" ""))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (str.to_re (seq.++ "3" (seq.++ "1" ""))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "," ",")(re.union (re.range "1" "1") (re.range "3" "9")))) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (re.union (str.to_re (seq.++ "2" (seq.++ "9" ""))) (str.to_re (seq.++ "3" (seq.++ "0" "")))))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (re.range "0" "9")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "1" "9") (re.range "0" "9")))) (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "1" "9"))))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "1" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (re.range "0" "9")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (re.range "0" "9"))))(re.union (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "1" "9") (re.range "0" "9")))) (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "1" "9"))))))) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "2" "2")(re.++ (re.union (re.range "-" "-") (re.range "/" "/")) (str.to_re (seq.++ "2" (seq.++ "9" ""))))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "0" "0")(re.++ (re.union (re.range "4" "4") (re.range "8" "8")) (str.to_re (seq.++ "0" (seq.++ "0" "")))))(re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))))(re.++ (re.union (re.range "2" "2") (re.range "6" "6")) (str.to_re (seq.++ "0" (seq.++ "0" "")))))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))(re.++ (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))) (str.to_re (seq.++ "0" (seq.++ "0" ""))))) (re.++ (re.opt (re.++ (re.range "0" "9") (re.range "0" "9"))) (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
