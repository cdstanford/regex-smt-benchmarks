;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(352)[8-9](\d{11}$|\d{12}$))|(^(35)[3-8](\d{12}$|\d{13}$))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "3528905758887989"
(define-fun Witness1 () String (str.++ "3" (str.++ "5" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "7" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ "9" "")))))))))))))))))
;witness2: "3584429438333838"
(define-fun Witness2 () String (str.++ "3" (str.++ "5" (str.++ "8" (str.++ "4" (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "3" (str.++ "8" (str.++ "3" (str.++ "3" (str.++ "3" (str.++ "8" (str.++ "3" (str.++ "8" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "3" (str.++ "5" (str.++ "2" ""))))(re.++ (re.range "8" "9") (re.union (re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "3" (str.++ "5" "")))(re.++ (re.range "3" "8") (re.union (re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
