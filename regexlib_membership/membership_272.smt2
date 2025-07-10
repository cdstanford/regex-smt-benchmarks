;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[+]\d{1,2}\(\d{2,3}\)\d{6,8}(\#\d{1,10})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+90(59)914186#089"
(define-fun Witness1 () String (str.++ "+" (str.++ "9" (str.++ "0" (str.++ "(" (str.++ "5" (str.++ "9" (str.++ ")" (str.++ "9" (str.++ "1" (str.++ "4" (str.++ "1" (str.++ "8" (str.++ "6" (str.++ "#" (str.++ "0" (str.++ "8" (str.++ "9" ""))))))))))))))))))
;witness2: "+96(88)098986"
(define-fun Witness2 () String (str.++ "+" (str.++ "9" (str.++ "6" (str.++ "(" (str.++ "8" (str.++ "8" (str.++ ")" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "6" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "+" "+")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "(" "(")(re.++ ((_ re.loop 2 3) (re.range "0" "9"))(re.++ (re.range ")" ")")(re.++ ((_ re.loop 6 8) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "#" "#") ((_ re.loop 1 10) (re.range "0" "9")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
