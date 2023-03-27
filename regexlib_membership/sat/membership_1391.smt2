;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[0]{1}$|^[-]?[1-9]{1}\d*$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "63"
(define-fun Witness1 () String (str.++ "6" (str.++ "3" "")))
;witness2: "-7"
(define-fun Witness2 () String (str.++ "-" (str.++ "7" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "0" "0") (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "1" "9")(re.++ (re.* (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
