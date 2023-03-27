;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]+(([\'\,\.\-][a-zA-Z])?[a-zA-Z]*)*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "wY"
(define-fun Witness1 () String (str.++ "w" (str.++ "Y" "")))
;witness2: "yaF"
(define-fun Witness2 () String (str.++ "y" (str.++ "a" (str.++ "F" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.opt (re.++ (re.union (re.range "'" "'") (re.range "," ".")) (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
