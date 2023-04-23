;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([01]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.){3}([01]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "188.108.199.229"
(define-fun Witness1 () String (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "." (str.++ "1" (str.++ "0" (str.++ "8" (str.++ "." (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "2" (str.++ "2" (str.++ "9" ""))))))))))))))))
;witness2: "03.222.4.113"
(define-fun Witness2 () String (str.++ "0" (str.++ "3" (str.++ "." (str.++ "2" (str.++ "2" (str.++ "2" (str.++ "." (str.++ "4" (str.++ "." (str.++ "1" (str.++ "1" (str.++ "3" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.opt (re.range "0" "1")) ((_ re.loop 1 2) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))) (re.range "." ".")))(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) ((_ re.loop 1 2) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
