;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-hA-H]{1}[1-8]{1})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "g6"
(define-fun Witness1 () String (str.++ "g" (str.++ "6" "")))
;witness2: "h3"
(define-fun Witness2 () String (str.++ "h" (str.++ "3" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "A" "H") (re.range "a" "h")) (re.range "1" "8")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
