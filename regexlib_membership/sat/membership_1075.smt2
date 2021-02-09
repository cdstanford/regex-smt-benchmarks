;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ES\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|ES\d{22}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0094ES59 4409 9996 9939 8684 9898"
(define-fun Witness1 () String (seq.++ "\x94" (seq.++ "E" (seq.++ "S" (seq.++ "5" (seq.++ "9" (seq.++ " " (seq.++ "4" (seq.++ "4" (seq.++ "0" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "4" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "8" "")))))))))))))))))))))))))))))))
;witness2: "ES69 5999 5854 8838 8872 7119"
(define-fun Witness2 () String (seq.++ "E" (seq.++ "S" (seq.++ "6" (seq.++ "9" (seq.++ " " (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "5" (seq.++ "8" (seq.++ "5" (seq.++ "4" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "2" (seq.++ " " (seq.++ "7" (seq.++ "1" (seq.++ "1" (seq.++ "9" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "E" (seq.++ "S" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (seq.++ "E" (seq.++ "S" ""))) ((_ re.loop 22 22) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
