;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[+]447\d{9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+447989995978"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "7" (seq.++ "8" ""))))))))))))))
;witness2: "+447997837967"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "3" (seq.++ "7" (seq.++ "9" (seq.++ "6" (seq.++ "7" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" (seq.++ "7" "")))))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
