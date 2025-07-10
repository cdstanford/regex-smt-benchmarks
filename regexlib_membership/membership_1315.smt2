;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([-]?[0-9]?(\.[0-9]{0,2})?)$|^([-]?([1][0-1])(\.[0-9]{0,2})?)$|^([-]?([1][0-3](\.[0]{0,2})))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "10."
(define-fun Witness1 () String (str.++ "1" (str.++ "0" (str.++ "." ""))))
;witness2: "-11.0"
(define-fun Witness2 () String (str.++ "-" (str.++ "1" (str.++ "1" (str.++ "." (str.++ "0" ""))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9")))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "-" "-"))(re.++ (re.++ (re.range "1" "1") (re.range "0" "1")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9")))))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "-" "-")) (re.++ (re.range "1" "1")(re.++ (re.range "0" "3") (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "0")))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
