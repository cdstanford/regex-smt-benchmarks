;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]%?$|^1[0-9]%?$|^2[0-9]%?$|^3[0-5]%?$|^[0-9]\.\d{1,2}%?$|^1[0-9]\.\d{1,2}%?$|^2[0-9]\.\d{1,2}%?$|^3[0-4]\.\d{1,2}%?$|^35%?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "2.49%"
(define-fun Witness1 () String (str.++ "2" (str.++ "." (str.++ "4" (str.++ "9" (str.++ "%" ""))))))
;witness2: "34.10%"
(define-fun Witness2 () String (str.++ "3" (str.++ "4" (str.++ "." (str.++ "1" (str.++ "0" (str.++ "%" "")))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "%" "%")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (re.range "1" "1")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "%" "%")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.range "2" "2")(re.++ (re.range "0" "9")(re.++ (re.opt (re.range "%" "%")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.range "3" "3")(re.++ (re.range "0" "5")(re.++ (re.opt (re.range "%" "%")) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.range "%" "%")) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.range "1" "1")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.range "%" "%")) (str.to_re "")))))))(re.union (re.++ (str.to_re "")(re.++ (re.range "2" "2")(re.++ (re.range "0" "9")(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.range "%" "%")) (str.to_re "")))))))(re.union (re.++ (str.to_re "")(re.++ (re.range "3" "3")(re.++ (re.range "0" "4")(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.range "%" "%")) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "3" (str.++ "5" "")))(re.++ (re.opt (re.range "%" "%")) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
