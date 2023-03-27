;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-2]?[1-9]{1}$|^3{1}[01]{1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "30"
(define-fun Witness1 () String (str.++ "3" (str.++ "0" "")))
;witness2: "31"
(define-fun Witness2 () String (str.++ "3" (str.++ "1" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "2"))(re.++ (re.range "1" "9") (str.to_re "")))) (re.++ (str.to_re "")(re.++ (re.range "3" "3")(re.++ (re.range "0" "1") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
