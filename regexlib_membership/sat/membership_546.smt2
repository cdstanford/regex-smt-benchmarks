;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?:\+|\-|\$)?(?:\d+|\d{1,3}(?:\,\d{3})*)(?:\.\d+)?(?:[a-zA-Z]{2}|\%)?)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "$48,493,851,827%"
(define-fun Witness1 () String (str.++ "$" (str.++ "4" (str.++ "8" (str.++ "," (str.++ "4" (str.++ "9" (str.++ "3" (str.++ "," (str.++ "8" (str.++ "5" (str.++ "1" (str.++ "," (str.++ "8" (str.++ "2" (str.++ "7" (str.++ "%" "")))))))))))))))))
;witness2: "+98%"
(define-fun Witness2 () String (str.++ "+" (str.++ "9" (str.++ "8" (str.++ "%" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.union (re.range "$" "$")(re.union (re.range "+" "+") (re.range "-" "-"))))(re.++ (re.union (re.+ (re.range "0" "9")) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))) (re.opt (re.union ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.range "%" "%")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
