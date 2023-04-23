;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z]{3})?([0-9]{4}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0468"
(define-fun Witness1 () String (str.++ "0" (str.++ "4" (str.++ "6" (str.++ "8" "")))))
;witness2: "9888"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z")))) ((_ re.loop 4 4) (re.range "0" "9"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
