;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = SK\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|SK\d{22}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "SK9829499584481999747863\u00EA"
(define-fun Witness1 () String (str.++ "S" (str.++ "K" (str.++ "9" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "4" (str.++ "4" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "4" (str.++ "7" (str.++ "8" (str.++ "6" (str.++ "3" (str.++ "\u{ea}" ""))))))))))))))))))))))))))
;witness2: "SK86 3839 8568 8998 5499 9083"
(define-fun Witness2 () String (str.++ "S" (str.++ "K" (str.++ "8" (str.++ "6" (str.++ " " (str.++ "3" (str.++ "8" (str.++ "3" (str.++ "9" (str.++ " " (str.++ "8" (str.++ "5" (str.++ "6" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "5" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "3" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "S" (str.++ "K" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (str.++ "S" (str.++ "K" ""))) ((_ re.loop 22 22) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
