;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(6011)\d{12}$)|(^(65)\d{14}$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6548198900899820"
(define-fun Witness1 () String (str.++ "6" (str.++ "5" (str.++ "4" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "0" "")))))))))))))))))
;witness2: "6549351288698198"
(define-fun Witness2 () String (str.++ "6" (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "3" (str.++ "5" (str.++ "1" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "8" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "6" (str.++ "0" (str.++ "1" (str.++ "1" "")))))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "6" (str.++ "5" "")))(re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
