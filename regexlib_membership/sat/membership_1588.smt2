;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d+|[a-zA-Z]+)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "90878"
(define-fun Witness1 () String (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "7" (str.++ "8" ""))))))
;witness2: "mQ"
(define-fun Witness2 () String (str.++ "m" (str.++ "Q" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.+ (re.range "0" "9")) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
