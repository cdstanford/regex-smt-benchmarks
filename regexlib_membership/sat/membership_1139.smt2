;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(102[0-3]|10[0-1]\d|[1-9][0-9]{0,2}|0)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0"
(define-fun Witness1 () String (str.++ "0" ""))
;witness2: "1022"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" (str.++ "2" (str.++ "2" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "2" "")))) (re.range "0" "3"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" "")))(re.++ (re.range "0" "1") (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") ((_ re.loop 0 2) (re.range "0" "9"))) (re.range "0" "0")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
