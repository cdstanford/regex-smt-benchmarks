;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(5[0678])\d{11,18}$)|(^(6[^05])\d{11,18}$)|(^(601)[^1]\d{9,16}$)|(^(6011)\d{9,11}$)|(^(6011)\d{13,16}$)|(^(65)\d{11,13}$)|(^(65)\d{15,18}$)|(^(49030)[2-9](\d{10}$|\d{12,13}$))|(^(49033)[5-9](\d{10}$|\d{12,13}$))|(^(49110)[1-2](\d{10}$|\d{12,13}$))|(^(49117)[4-9](\d{10}$|\d{12,13}$))|(^(49118)[0-2](\d{10}$|\d{12,13}$))|(^(4936)(\d{12}$|\d{14,15}$))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "601\u0098098109339"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "\x98" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "0" (seq.++ "9" (seq.++ "3" (seq.++ "3" (seq.++ "9" ""))))))))))))))
;witness2: "491180066984268328"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ "6" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "2" (seq.++ "6" (seq.++ "8" (seq.++ "3" (seq.++ "2" (seq.++ "8" "")))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "5" "5") (re.union (re.range "0" "0") (re.range "6" "8")))(re.++ ((_ re.loop 11 18) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "6" "6") (re.union (re.range "\x00" "/")(re.union (re.range "1" "4") (re.range "6" "\xff"))))(re.++ ((_ re.loop 11 18) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" ""))))(re.++ (re.union (re.range "\x00" "0") (re.range "2" "\xff"))(re.++ ((_ re.loop 9 16) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" "")))))(re.++ ((_ re.loop 9 11) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" "")))))(re.++ ((_ re.loop 13 16) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "6" (seq.++ "5" "")))(re.++ ((_ re.loop 11 13) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "6" (seq.++ "5" "")))(re.++ ((_ re.loop 15 18) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "0" ""))))))(re.++ (re.range "2" "9") (re.union (re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 12 13) (re.range "0" "9")) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "3" ""))))))(re.++ (re.range "5" "9") (re.union (re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 12 13) (re.range "0" "9")) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "0" ""))))))(re.++ (re.range "1" "2") (re.union (re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 12 13) (re.range "0" "9")) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "7" ""))))))(re.++ (re.range "4" "9") (re.union (re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 12 13) (re.range "0" "9")) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "8" ""))))))(re.++ (re.range "0" "2") (re.union (re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 12 13) (re.range "0" "9")) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "3" (seq.++ "6" ""))))) (re.union (re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 14 15) (re.range "0" "9")) (str.to_re "")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
