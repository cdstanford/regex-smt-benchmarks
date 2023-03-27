;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9][0-9,]*[0-9]$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "890"
(define-fun Witness1 () String (str.++ "8" (str.++ "9" (str.++ "0" ""))))
;witness2: "70"
(define-fun Witness2 () String (str.++ "7" (str.++ "0" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "9")(re.++ (re.* (re.union (re.range "," ",") (re.range "0" "9")))(re.++ (re.range "0" "9") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
