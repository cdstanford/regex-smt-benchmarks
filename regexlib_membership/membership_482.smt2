;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]+\.?[0-9]?[0-9]?[0,5]?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "928."
(define-fun Witness1 () String (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "." "")))))
;witness2: "253480"
(define-fun Witness2 () String (str.++ "2" (str.++ "5" (str.++ "3" (str.++ "4" (str.++ "8" (str.++ "0" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "," ",")(re.union (re.range "0" "0") (re.range "5" "5")))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
