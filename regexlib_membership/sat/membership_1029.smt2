;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(EE|EL|DE|PT){0,1}[0-9]{9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "EE607366299"
(define-fun Witness1 () String (seq.++ "E" (seq.++ "E" (seq.++ "6" (seq.++ "0" (seq.++ "7" (seq.++ "3" (seq.++ "6" (seq.++ "6" (seq.++ "2" (seq.++ "9" (seq.++ "9" ""))))))))))))
;witness2: "EL906983884"
(define-fun Witness2 () String (seq.++ "E" (seq.++ "L" (seq.++ "9" (seq.++ "0" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "4" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (seq.++ "E" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "E" (seq.++ "L" "")))(re.union (str.to_re (seq.++ "D" (seq.++ "E" ""))) (str.to_re (seq.++ "P" (seq.++ "T" "")))))))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
