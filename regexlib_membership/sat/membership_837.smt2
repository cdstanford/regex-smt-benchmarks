;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(30)[0-5]\d{11}$)|(^(36)\d{12}$)|(^(38[0-8])\d{11}$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "38583991982935"
(define-fun Witness1 () String (str.++ "3" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "3" (str.++ "5" "")))))))))))))))
;witness2: "30031905985199"
(define-fun Witness2 () String (str.++ "3" (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "5" (str.++ "1" (str.++ "9" (str.++ "9" "")))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "3" (str.++ "0" "")))(re.++ (re.range "0" "5")(re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "3" (str.++ "6" "")))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (str.++ "3" (str.++ "8" ""))) (re.range "0" "8"))(re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
