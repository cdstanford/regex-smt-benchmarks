;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((18[5-9][0-9])|((19|20)[0-9]{2})|(2100))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1878"
(define-fun Witness1 () String (str.++ "1" (str.++ "8" (str.++ "7" (str.++ "8" "")))))
;witness2: "1874"
(define-fun Witness2 () String (str.++ "1" (str.++ "8" (str.++ "7" (str.++ "4" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "8" "")))(re.++ (re.range "5" "9") (re.range "0" "9")))(re.union (re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (str.to_re (str.++ "2" (str.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9"))) (str.to_re (str.++ "2" (str.++ "1" (str.++ "0" (str.++ "0" ""))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
