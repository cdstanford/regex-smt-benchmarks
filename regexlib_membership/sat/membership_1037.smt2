;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((l((ll)|(b)|(bb)|(bbb)))|(bb*))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "lbbb"
(define-fun Witness1 () String (str.++ "l" (str.++ "b" (str.++ "b" (str.++ "b" "")))))
;witness2: "bb"
(define-fun Witness2 () String (str.++ "b" (str.++ "b" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "l" "l") (re.union (str.to_re (str.++ "l" (str.++ "l" "")))(re.union (re.range "b" "b")(re.union (str.to_re (str.++ "b" (str.++ "b" ""))) (str.to_re (str.++ "b" (str.++ "b" (str.++ "b" "")))))))) (re.++ (re.range "b" "b") (re.* (re.range "b" "b")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
