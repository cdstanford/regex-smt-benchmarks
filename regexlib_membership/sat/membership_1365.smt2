;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((^\d{5}$)|(^\d{8}$))|(^\d{5}-\d{3}$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "96925-987"
(define-fun Witness1 () String (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "2" (str.++ "5" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "7" ""))))))))))
;witness2: "88443-843"
(define-fun Witness2 () String (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "4" (str.++ "3" (str.++ "-" (str.++ "8" (str.++ "4" (str.++ "3" ""))))))))))

(assert (= regexA (re.union (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re ""))) (re.++ (str.to_re "")(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
