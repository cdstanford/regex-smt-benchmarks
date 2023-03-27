;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})){3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "94.248.81.8"
(define-fun Witness1 () String (str.++ "9" (str.++ "4" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "1" (str.++ "." (str.++ "8" ""))))))))))))
;witness2: "212.218.250.239"
(define-fun Witness2 () String (str.++ "2" (str.++ "1" (str.++ "2" (str.++ "." (str.++ "2" (str.++ "1" (str.++ "8" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "0" (str.++ "." (str.++ "2" (str.++ "3" (str.++ "9" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9"))) ((_ re.loop 1 2) (re.range "0" "9")))))(re.++ ((_ re.loop 3 3) (re.++ (re.range "." ".") (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9"))) ((_ re.loop 1 2) (re.range "0" "9"))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
