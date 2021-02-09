;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]{12},)+[0-9]{12}$|^([0-9]{12})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "785286888879,293857942999"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "8" (seq.++ "5" (seq.++ "2" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "9" (seq.++ "," (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "5" (seq.++ "7" (seq.++ "9" (seq.++ "4" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "9" ""))))))))))))))))))))))))))
;witness2: "697919738889,597971808550,996888198878,986966598019,999898899903,880898088388"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "1" (seq.++ "9" (seq.++ "7" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "," (seq.++ "5" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "7" (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "5" (seq.++ "5" (seq.++ "0" (seq.++ "," (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ "," (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "6" (seq.++ "6" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "1" (seq.++ "9" (seq.++ "," (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "3" (seq.++ "," (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "8" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.+ (re.++ ((_ re.loop 12 12) (re.range "0" "9")) (re.range "," ",")))(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ ((_ re.loop 12 12) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
