;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-+]?\d*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+49"
(define-fun Witness1 () String (str.++ "+" (str.++ "4" (str.++ "9" ""))))
;witness2: "+89"
(define-fun Witness2 () String (str.++ "+" (str.++ "8" (str.++ "9" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
