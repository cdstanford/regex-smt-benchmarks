;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?:\+27|27)|0)(\d{2})-?(\d{3})-?(\d{4})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "27426202567"
(define-fun Witness1 () String (str.++ "2" (str.++ "7" (str.++ "4" (str.++ "2" (str.++ "6" (str.++ "2" (str.++ "0" (str.++ "2" (str.++ "5" (str.++ "6" (str.++ "7" ""))))))))))))
;witness2: "+2789791-8883"
(define-fun Witness2 () String (str.++ "+" (str.++ "2" (str.++ "7" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "1" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "3" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "+" (str.++ "2" (str.++ "7" ""))))(re.union (str.to_re (str.++ "2" (str.++ "7" ""))) (re.range "0" "0")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
