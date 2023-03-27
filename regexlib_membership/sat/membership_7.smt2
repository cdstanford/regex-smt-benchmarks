;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [NS] \d{1,}(\:[0-5]\d){2}.{0,1}\d{0,},[EW] \d{1,}(\:[0-5]\d){2}.{0,1}\d{0,}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "N 488:14:38\u00AD87,E 9:03:43"
(define-fun Witness1 () String (str.++ "N" (str.++ " " (str.++ "4" (str.++ "8" (str.++ "8" (str.++ ":" (str.++ "1" (str.++ "4" (str.++ ":" (str.++ "3" (str.++ "8" (str.++ "\u{ad}" (str.++ "8" (str.++ "7" (str.++ "," (str.++ "E" (str.++ " " (str.++ "9" (str.++ ":" (str.++ "0" (str.++ "3" (str.++ ":" (str.++ "4" (str.++ "3" "")))))))))))))))))))))))))
;witness2: "\u00BDS 7629337:57:59\u00C8,E 9863768:02:583"
(define-fun Witness2 () String (str.++ "\u{bd}" (str.++ "S" (str.++ " " (str.++ "7" (str.++ "6" (str.++ "2" (str.++ "9" (str.++ "3" (str.++ "3" (str.++ "7" (str.++ ":" (str.++ "5" (str.++ "7" (str.++ ":" (str.++ "5" (str.++ "9" (str.++ "\u{c8}" (str.++ "," (str.++ "E" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "3" (str.++ "7" (str.++ "6" (str.++ "8" (str.++ ":" (str.++ "0" (str.++ "2" (str.++ ":" (str.++ "5" (str.++ "8" (str.++ "3" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.range "N" "N") (re.range "S" "S"))(re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ (re.union (re.range "E" "E") (re.range "W" "W"))(re.++ (re.range " " " ")(re.++ (re.+ (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.* (re.range "0" "9"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
