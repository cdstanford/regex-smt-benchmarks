;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{2,3}|\(\d{2,3}\))[ ]?\d{3,4}[-]?\d{3,4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "897 9968987"
(define-fun Witness1 () String (str.++ "8" (str.++ "9" (str.++ "7" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "7" ""))))))))))))
;witness2: "96 1083525"
(define-fun Witness2 () String (str.++ "9" (str.++ "6" (str.++ " " (str.++ "1" (str.++ "0" (str.++ "8" (str.++ "3" (str.++ "5" (str.++ "2" (str.++ "5" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 2 3) (re.range "0" "9")) (re.++ (re.range "(" "(")(re.++ ((_ re.loop 2 3) (re.range "0" "9")) (re.range ")" ")"))))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
