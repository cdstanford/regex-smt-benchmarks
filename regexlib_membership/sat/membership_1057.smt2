;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([12]?[0-9]|3[01])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "15"
(define-fun Witness1 () String (str.++ "1" (str.++ "5" "")))
;witness2: "30"
(define-fun Witness2 () String (str.++ "3" (str.++ "0" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "1" "2")) (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
