;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = PL\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}|PL\d{26}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xAPL85 7798 9915 8888 8997 9840 5223"
(define-fun Witness1 () String (str.++ "\u{0a}" (str.++ "P" (str.++ "L" (str.++ "8" (str.++ "5" (str.++ " " (str.++ "7" (str.++ "7" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "5" (str.++ " " (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "0" (str.++ " " (str.++ "5" (str.++ "2" (str.++ "2" (str.++ "3" ""))))))))))))))))))))))))))))))))))))
;witness2: "nPL89 6557 8483 9788 9908 1171 5194\u00F2\u0095"
(define-fun Witness2 () String (str.++ "n" (str.++ "P" (str.++ "L" (str.++ "8" (str.++ "9" (str.++ " " (str.++ "6" (str.++ "5" (str.++ "5" (str.++ "7" (str.++ " " (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "3" (str.++ " " (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ " " (str.++ "1" (str.++ "1" (str.++ "7" (str.++ "1" (str.++ " " (str.++ "5" (str.++ "1" (str.++ "9" (str.++ "4" (str.++ "\u{f2}" (str.++ "\u{95}" ""))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "P" (str.++ "L" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))))))))) (re.++ (str.to_re (str.++ "P" (str.++ "L" ""))) ((_ re.loop 26 26) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
