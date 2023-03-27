;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = DE\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{2}|DE\d{20}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x1C\u00B2DE82 2999 1878 9386 8878 92\u0083\""
(define-fun Witness1 () String (str.++ "\u{1c}" (str.++ "\u{b2}" (str.++ "D" (str.++ "E" (str.++ "8" (str.++ "2" (str.++ " " (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "1" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "6" (str.++ " " (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "2" (str.++ "\u{83}" (str.++ "\u{22}" ""))))))))))))))))))))))))))))))))
;witness2: "9DE23 8579 5878 9879 9059 99\u00F2"
(define-fun Witness2 () String (str.++ "9" (str.++ "D" (str.++ "E" (str.++ "2" (str.++ "3" (str.++ " " (str.++ "8" (str.++ "5" (str.++ "7" (str.++ "9" (str.++ " " (str.++ "5" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "\u{f2}" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "D" (str.++ "E" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 2 2) (re.range "0" "9"))))))))))))) (re.++ (str.to_re (str.++ "D" (str.++ "E" ""))) ((_ re.loop 20 20) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
