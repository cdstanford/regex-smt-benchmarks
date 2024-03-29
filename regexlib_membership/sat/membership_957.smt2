;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((\+44)? ?(\(0\))? ?)|(0))( ?[0-9]{3,4}){3}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "07638959 693@k\u00D3"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ "6" (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "9" (str.++ " " (str.++ "6" (str.++ "9" (str.++ "3" (str.++ "@" (str.++ "k" (str.++ "\u{d3}" ""))))))))))))))))
;witness2: "D 9383 929 499O"
(define-fun Witness2 () String (str.++ "D" (str.++ " " (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "3" (str.++ " " (str.++ "9" (str.++ "2" (str.++ "9" (str.++ " " (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "O" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.opt (str.to_re (str.++ "+" (str.++ "4" (str.++ "4" "")))))(re.++ (re.opt (re.range " " " "))(re.++ (re.opt (str.to_re (str.++ "(" (str.++ "0" (str.++ ")" ""))))) (re.opt (re.range " " " "))))) (re.range "0" "0")) ((_ re.loop 3 3) (re.++ (re.opt (re.range " " " ")) ((_ re.loop 3 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
