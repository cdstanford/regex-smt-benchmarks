;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1]$|^[3]$|^[4]$|^[6]$|^[1]0$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1"
(define-fun Witness1 () String (str.++ "1" ""))
;witness2: "10"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "1" "1") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "3" "3") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "4" "4") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "6" "6") (str.to_re ""))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "1" (str.++ "0" ""))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
