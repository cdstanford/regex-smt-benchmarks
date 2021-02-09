;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^4\d{12}$)|(^4[0-8]\d{14}$)|(^(49)[^013]\d{13}$)|(^(49030)[0-1]\d{10}$)|(^(49033)[0-4]\d{10}$)|(^(49110)[^12]\d{10}$)|(^(49117)[0-3]\d{10}$)|(^(49118)[^0-2]\d{10}$)|(^(493)[^6]\d{12}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4903016088388408"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "0" (seq.++ "1" (seq.++ "6" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "0" (seq.++ "8" "")))))))))))))))))
;witness2: "4903009138998869"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "0" (seq.++ "0" (seq.++ "9" (seq.++ "1" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "9" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "4" "4")(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (re.range "4" "4")(re.++ (re.range "0" "8")(re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" "")))(re.++ (re.union (re.range "\x00" "/")(re.union (re.range "2" "2") (re.range "4" "\xff")))(re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "0" ""))))))(re.++ (re.range "0" "1")(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "3" ""))))))(re.++ (re.range "0" "4")(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "0" ""))))))(re.++ (re.union (re.range "\x00" "0") (re.range "3" "\xff"))(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "7" ""))))))(re.++ (re.range "0" "3")(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "1" (seq.++ "1" (seq.++ "8" ""))))))(re.++ (re.union (re.range "\x00" "/") (re.range "3" "\xff"))(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "4" (seq.++ "9" (seq.++ "3" ""))))(re.++ (re.union (re.range "\x00" "5") (re.range "7" "\xff"))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
