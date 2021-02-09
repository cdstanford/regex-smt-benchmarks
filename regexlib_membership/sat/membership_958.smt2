;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\+[0-9]{1,3}\([0-9]{3}\)[0-9]{7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+26(586)2994025"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "2" (seq.++ "6" (seq.++ "(" (seq.++ "5" (seq.++ "8" (seq.++ "6" (seq.++ ")" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "4" (seq.++ "0" (seq.++ "2" (seq.++ "5" ""))))))))))))))))
;witness2: "+8(068)9898085"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "8" (seq.++ "(" (seq.++ "0" (seq.++ "6" (seq.++ "8" (seq.++ ")" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "5" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "+" "+")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
