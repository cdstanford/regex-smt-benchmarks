;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\+?972(\-)?0?[23489]{1}(\-)?[^0\D]{1}\d{6}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+972023829154"
(define-fun Witness1 () String (str.++ "+" (str.++ "9" (str.++ "7" (str.++ "2" (str.++ "0" (str.++ "2" (str.++ "3" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "1" (str.++ "5" (str.++ "4" ""))))))))))))))
;witness2: "9728-8989834"
(define-fun Witness2 () String (str.++ "9" (str.++ "7" (str.++ "2" (str.++ "8" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "4" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (str.++ "9" (str.++ "7" (str.++ "2" ""))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "0" "0"))(re.++ (re.union (re.range "2" "4") (re.range "8" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
