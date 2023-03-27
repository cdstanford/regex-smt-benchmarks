;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z0-9]{5})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "AJ99V"
(define-fun Witness1 () String (str.++ "A" (str.++ "J" (str.++ "9" (str.++ "9" (str.++ "V" ""))))))
;witness2: "Z39V8"
(define-fun Witness2 () String (str.++ "Z" (str.++ "3" (str.++ "9" (str.++ "V" (str.++ "8" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.union (re.range "0" "9") (re.range "A" "Z"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
