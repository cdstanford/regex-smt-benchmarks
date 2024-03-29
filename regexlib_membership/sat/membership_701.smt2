;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([9]{1})([234789]{1})([0-9]{8})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9974459092"
(define-fun Witness1 () String (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "4" (str.++ "4" (str.++ "5" (str.++ "9" (str.++ "0" (str.++ "9" (str.++ "2" "")))))))))))
;witness2: "9899639989"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "9" "9")(re.++ (re.union (re.range "2" "4") (re.range "7" "9"))(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
