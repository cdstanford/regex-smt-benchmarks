;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9a-zA-z]{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "C80"
(define-fun Witness1 () String (str.++ "C" (str.++ "8" (str.++ "0" ""))))
;witness2: "u89"
(define-fun Witness2 () String (str.++ "u" (str.++ "8" (str.++ "9" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9") (re.range "A" "z"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
