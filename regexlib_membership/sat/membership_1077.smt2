;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = SK\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|SK\d{22}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "SK9829499584481999747863\u00EA"
(define-fun Witness1 () String (seq.++ "S" (seq.++ "K" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "4" (seq.++ "4" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "4" (seq.++ "7" (seq.++ "8" (seq.++ "6" (seq.++ "3" (seq.++ "\xea" ""))))))))))))))))))))))))))
;witness2: "SK86 3839 8568 8998 5499 9083"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "K" (seq.++ "8" (seq.++ "6" (seq.++ " " (seq.++ "3" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "5" (seq.++ "6" (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "5" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "3" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "S" (seq.++ "K" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (seq.++ "S" (seq.++ "K" ""))) ((_ re.loop 22 22) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
