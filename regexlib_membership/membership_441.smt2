;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{12},)+[0-9]{12}$|^([0-9]{12})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "785286888879,293857942999"
(define-fun Witness1 () String (str.++ "7" (str.++ "8" (str.++ "5" (str.++ "2" (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "," (str.++ "2" (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "5" (str.++ "7" (str.++ "9" (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "9" ""))))))))))))))))))))))))))
;witness2: "697919738889,597971808550,996888198878,986966598019,999898899903,880898088388"
(define-fun Witness2 () String (str.++ "6" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "7" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "," (str.++ "5" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "7" (str.++ "1" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "5" (str.++ "5" (str.++ "0" (str.++ "," (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "," (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "6" (str.++ "6" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "1" (str.++ "9" (str.++ "," (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "0" (str.++ "3" (str.++ "," (str.++ "8" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "8" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.+ (re.++ ((_ re.loop 12 12) (re.range "0" "9")) (re.range "," ",")))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
