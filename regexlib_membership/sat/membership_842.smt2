;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^4\d{12}$)|(^4[0-8]\d{14}$)|(^(49)[^013]\d{13}$)|(^(49030)[0-1]\d{10}$)|(^(49033)[0-4]\d{10}$)|(^(49110)[^12]\d{10}$)|(^(49117)[0-3]\d{10}$)|(^(49118)[^0-2]\d{10}$)|(^(493)[^6]\d{12}$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4903016088388408"
(define-fun Witness1 () String (str.++ "4" (str.++ "9" (str.++ "0" (str.++ "3" (str.++ "0" (str.++ "1" (str.++ "6" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "0" (str.++ "8" "")))))))))))))))))
;witness2: "4903009138998869"
(define-fun Witness2 () String (str.++ "4" (str.++ "9" (str.++ "0" (str.++ "3" (str.++ "0" (str.++ "0" (str.++ "9" (str.++ "1" (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "9" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "4" "4")(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (re.range "4" "4")(re.++ (re.range "0" "8")(re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "4" (str.++ "9" "")))(re.++ (re.union (re.range "\u{00}" "/")(re.union (re.range "2" "2") (re.range "4" "\u{ff}")))(re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "0" (str.++ "3" (str.++ "0" ""))))))(re.++ (re.range "0" "1")(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "0" (str.++ "3" (str.++ "3" ""))))))(re.++ (re.range "0" "4")(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "1" (str.++ "1" (str.++ "0" ""))))))(re.++ (re.union (re.range "\u{00}" "0") (re.range "3" "\u{ff}"))(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "1" (str.++ "1" (str.++ "7" ""))))))(re.++ (re.range "0" "3")(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "1" (str.++ "1" (str.++ "8" ""))))))(re.++ (re.union (re.range "\u{00}" "/") (re.range "3" "\u{ff}"))(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "4" (str.++ "9" (str.++ "3" ""))))(re.++ (re.union (re.range "\u{00}" "5") (re.range "7" "\u{ff}"))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
