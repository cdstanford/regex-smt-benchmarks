;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:\([2-9]\d{2}\)\ ?|(?:[2-9]\d{2}\-))[2-9]\d{2}\-\d{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "881-881-3806"
(define-fun Witness1 () String (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "-" (str.++ "3" (str.++ "8" (str.++ "0" (str.++ "6" "")))))))))))))
;witness2: "999-307-8075"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "3" (str.++ "0" (str.++ "7" (str.++ "-" (str.++ "8" (str.++ "0" (str.++ "7" (str.++ "5" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "(" "(")(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.range " " " ")))))) (re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.range "-" "-"))))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
