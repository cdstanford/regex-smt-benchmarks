;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([4]{1})([0-9]{12,15})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "428338889989989"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "2" (seq.++ "8" (seq.++ "3" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" ""))))))))))))))))
;witness2: "496145186980933"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "9" (seq.++ "6" (seq.++ "1" (seq.++ "4" (seq.++ "5" (seq.++ "1" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "3" (seq.++ "3" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "4" "4")(re.++ ((_ re.loop 12 15) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
