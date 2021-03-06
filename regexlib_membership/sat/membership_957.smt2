;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((\+44)? ?(\(0\))? ?)|(0))( ?[0-9]{3,4}){3}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "07638959 693@k\u00D3"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "7" (seq.++ "6" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ " " (seq.++ "6" (seq.++ "9" (seq.++ "3" (seq.++ "@" (seq.++ "k" (seq.++ "\xd3" ""))))))))))))))))
;witness2: "D 9383 929 499O"
(define-fun Witness2 () String (seq.++ "D" (seq.++ " " (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "3" (seq.++ " " (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ " " (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "O" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.opt (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "4" "")))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (str.to_re (seq.++ "(" (seq.++ "0" (seq.++ ")" ""))))) (re.opt (re.range " " " "))))) (re.range "0" "0")) ((_ re.loop 3 3) (re.++ (re.opt (re.range " " " ")) ((_ re.loop 3 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
