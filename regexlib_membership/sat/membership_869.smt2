;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((0[1-9]|[12][0-9]|3[01])(0[13578]|10|12)(\d{2}))|(([0][1-9]|[12][0-9]|30)(0[469]|11)(\d{2}))|((0[1-9]|1[0-9]|2[0-8])(02)(\d{2}))|((29)(02)(00))|((29)(02)([2468][048]))|((29)(02)([13579][26])))[-]\d{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "051298-7998"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ "1" (seq.++ "2" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "8" ""))))))))))))
;witness2: "191198-9495"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "4" (seq.++ "9" (seq.++ "5" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))))(re.union (str.to_re (seq.++ "1" (seq.++ "0" ""))) (str.to_re (seq.++ "1" (seq.++ "2" ""))))) ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (seq.++ "3" (seq.++ "0" "")))))(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (seq.++ "1" (seq.++ "1" "")))) ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))(re.++ (str.to_re (seq.++ "0" (seq.++ "2" ""))) ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "9" "")))(re.++ (str.to_re (seq.++ "0" (seq.++ "2" ""))) (str.to_re (seq.++ "0" (seq.++ "0" "")))))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "9" "")))(re.++ (str.to_re (seq.++ "0" (seq.++ "2" ""))) (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))))) (re.++ (str.to_re (seq.++ "2" (seq.++ "9" "")))(re.++ (str.to_re (seq.++ "0" (seq.++ "2" ""))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))))))))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
