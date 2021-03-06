;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = DE\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{2}|DE\d{20}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1C\u00B2DE82 2999 1878 9386 8878 92\u0083\""
(define-fun Witness1 () String (seq.++ "\x1c" (seq.++ "\xb2" (seq.++ "D" (seq.++ "E" (seq.++ "8" (seq.++ "2" (seq.++ " " (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "1" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ " " (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "6" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ " " (seq.++ "9" (seq.++ "2" (seq.++ "\x83" (seq.++ "\x22" ""))))))))))))))))))))))))))))))))
;witness2: "9DE23 8579 5878 9879 9059 99\u00F2"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "D" (seq.++ "E" (seq.++ "2" (seq.++ "3" (seq.++ " " (seq.++ "8" (seq.++ "5" (seq.++ "7" (seq.++ "9" (seq.++ " " (seq.++ "5" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "7" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "0" (seq.++ "5" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "\xf2" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "D" (seq.++ "E" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 2 2) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (seq.++ "D" (seq.++ "E" ""))) ((_ re.loop 20 20) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
