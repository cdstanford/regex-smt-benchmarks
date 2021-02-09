;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[+]\d{1,2}\(\d{2,3}\)\d{6,8}(\#\d{1,10})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+90(59)914186#089"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "9" (seq.++ "0" (seq.++ "(" (seq.++ "5" (seq.++ "9" (seq.++ ")" (seq.++ "9" (seq.++ "1" (seq.++ "4" (seq.++ "1" (seq.++ "8" (seq.++ "6" (seq.++ "#" (seq.++ "0" (seq.++ "8" (seq.++ "9" ""))))))))))))))))))
;witness2: "+96(88)098986"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "9" (seq.++ "6" (seq.++ "(" (seq.++ "8" (seq.++ "8" (seq.++ ")" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "6" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "+" "+")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "(" "(")(re.++ ((_ re.loop 2 3) (re.range "0" "9"))(re.++ (re.range ")" ")")(re.++ ((_ re.loop 6 8) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "#" "#") ((_ re.loop 1 10) (re.range "0" "9")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
