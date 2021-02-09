;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(IT|LV){0,1}[0-9]{11}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "27884833615"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "3" (seq.++ "3" (seq.++ "6" (seq.++ "1" (seq.++ "5" ""))))))))))))
;witness2: "71679972968"
(define-fun Witness2 () String (seq.++ "7" (seq.++ "1" (seq.++ "6" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "2" (seq.++ "9" (seq.++ "6" (seq.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (seq.++ "I" (seq.++ "T" ""))) (str.to_re (seq.++ "L" (seq.++ "V" "")))))(re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
