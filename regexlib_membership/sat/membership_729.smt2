;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[3|4|5|6]([0-9]{15}$|[0-9]{12}$|[0-9]{13}$|[0-9]{14}$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "39698499993218"
(define-fun Witness1 () String (str.++ "3" (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "2" (str.++ "1" (str.++ "8" "")))))))))))))))
;witness2: "|998696998998601"
(define-fun Witness2 () String (str.++ "|" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "0" (str.++ "1" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "3" "6") (re.range "|" "|")) (re.union (re.++ ((_ re.loop 15 15) (re.range "0" "9")) (str.to_re ""))(re.union (re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re ""))(re.union (re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
