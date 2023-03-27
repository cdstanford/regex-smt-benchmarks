;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((192\.168\.0\.)(1[7-9]|2[0-9]|3[0-2]))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "192.168.0.32"
(define-fun Witness1 () String (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "." (str.++ "0" (str.++ "." (str.++ "3" (str.++ "2" "")))))))))))))
;witness2: "192.168.0.29"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "." (str.++ "0" (str.++ "." (str.++ "2" (str.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "." (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "." (str.++ "0" (str.++ "." ""))))))))))) (re.union (re.++ (re.range "1" "1") (re.range "7" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "2"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
