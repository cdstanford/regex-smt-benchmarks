;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z][a-z]+((eir|(n|l)h)(a|o))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Qyeiro"
(define-fun Witness1 () String (str.++ "Q" (str.++ "y" (str.++ "e" (str.++ "i" (str.++ "r" (str.++ "o" "")))))))
;witness2: "Kmnho"
(define-fun Witness2 () String (str.++ "K" (str.++ "m" (str.++ "n" (str.++ "h" (str.++ "o" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.++ (re.union (str.to_re (str.++ "e" (str.++ "i" (str.++ "r" "")))) (re.++ (re.union (re.range "l" "l") (re.range "n" "n")) (re.range "h" "h"))) (re.union (re.range "a" "a") (re.range "o" "o"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
