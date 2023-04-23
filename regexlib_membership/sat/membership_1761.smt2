;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]{1}[0-9]{3} ?[A-Z]{2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "8694GY"
(define-fun Witness1 () String (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "4" (str.++ "G" (str.++ "Y" "")))))))
;witness2: "5747 WF"
(define-fun Witness2 () String (str.++ "5" (str.++ "7" (str.++ "4" (str.++ "7" (str.++ " " (str.++ "W" (str.++ "F" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 2 2) (re.range "A" "Z")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
