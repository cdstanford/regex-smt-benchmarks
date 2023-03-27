;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{4,}$|^[3-9]\d{2}$|^2[5-9]\d$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "8115"
(define-fun Witness1 () String (str.++ "8" (str.++ "1" (str.++ "1" (str.++ "5" "")))))
;witness2: "299"
(define-fun Witness2 () String (str.++ "2" (str.++ "9" (str.++ "9" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.* (re.range "0" "9"))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "3" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))) (re.++ (str.to_re "")(re.++ (re.range "2" "2")(re.++ (re.range "5" "9")(re.++ (re.range "0" "9") (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
