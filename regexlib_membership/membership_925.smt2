;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\+)?(\d{2})[-])?(([\(])?((\d){3,5})([\)])?[-])|(\d{3,5})(\d{5,8}){1}?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "86538158"
(define-fun Witness1 () String (str.++ "8" (str.++ "6" (str.++ "5" (str.++ "3" (str.++ "8" (str.++ "1" (str.++ "5" (str.++ "8" "")))))))))
;witness2: "+18-(999-\u00D4"
(define-fun Witness2 () String (str.++ "+" (str.++ "1" (str.++ "8" (str.++ "-" (str.++ "(" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "\u{d4}" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.range "-" "-")))) (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 5) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")")) (re.range "-" "-")))))) (re.++ ((_ re.loop 3 5) (re.range "0" "9"))(re.++ ((_ re.loop 5 8) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
