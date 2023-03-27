;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0?[1-9])|((1|2)[0-9])|30|31)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "31"
(define-fun Witness1 () String (str.++ "3" (str.++ "1" "")))
;witness2: "08"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9"))(re.union (str.to_re (str.++ "3" (str.++ "0" ""))) (str.to_re (str.++ "3" (str.++ "1" "")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
