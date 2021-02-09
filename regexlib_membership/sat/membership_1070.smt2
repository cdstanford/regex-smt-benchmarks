;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = PL\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|PL\d{26}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xAPL85 7798 9915 8888 8997 9840 5223"
(define-fun Witness1 () String (seq.++ "\x0a" (seq.++ "P" (seq.++ "L" (seq.++ "8" (seq.++ "5" (seq.++ " " (seq.++ "7" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "1" (seq.++ "5" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "0" (seq.++ " " (seq.++ "5" (seq.++ "2" (seq.++ "2" (seq.++ "3" ""))))))))))))))))))))))))))))))))))))
;witness2: "nPL89 6557 8483 9788 9908 1171 5194\u00F2\u0095"
(define-fun Witness2 () String (seq.++ "n" (seq.++ "P" (seq.++ "L" (seq.++ "8" (seq.++ "9" (seq.++ " " (seq.++ "6" (seq.++ "5" (seq.++ "5" (seq.++ "7" (seq.++ " " (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "3" (seq.++ " " (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ " " (seq.++ "1" (seq.++ "1" (seq.++ "7" (seq.++ "1" (seq.++ " " (seq.++ "5" (seq.++ "1" (seq.++ "9" (seq.++ "4" (seq.++ "\xf2" (seq.++ "\x95" ""))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "P" (seq.++ "L" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))))) (re.++ (str.to_re (seq.++ "P" (seq.++ "L" ""))) ((_ re.loop 26 26) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
