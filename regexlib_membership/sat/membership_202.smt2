;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1][0-9]|2[0-3]){1}:([0-5][0-9]){1}:([0-5][0-9]){1},([0-9][0-9][0-9]){1} --> ([0-1][0-9]|2[0-3]){1}:([0-5][0-9]){1}:([0-5][0-9]){1},([0-9][0-9][0-9]){1}(.*)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "21:18:52,884 --> 23:11:09,552A"
(define-fun Witness1 () String (str.++ "2" (str.++ "1" (str.++ ":" (str.++ "1" (str.++ "8" (str.++ ":" (str.++ "5" (str.++ "2" (str.++ "," (str.++ "8" (str.++ "8" (str.++ "4" (str.++ " " (str.++ "-" (str.++ "-" (str.++ ">" (str.++ " " (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "1" (str.++ "1" (str.++ ":" (str.++ "0" (str.++ "9" (str.++ "," (str.++ "5" (str.++ "5" (str.++ "2" (str.++ "A" "")))))))))))))))))))))))))))))))
;witness2: "21:49:03,898 --> 23:37:45,676\u0083"
(define-fun Witness2 () String (str.++ "2" (str.++ "1" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ ":" (str.++ "0" (str.++ "3" (str.++ "," (str.++ "8" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "-" (str.++ "-" (str.++ ">" (str.++ " " (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "3" (str.++ "7" (str.++ ":" (str.++ "4" (str.++ "5" (str.++ "," (str.++ "6" (str.++ "7" (str.++ "6" (str.++ "\u{83}" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ (re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.++ (str.to_re (str.++ " " (str.++ "-" (str.++ "-" (str.++ ">" (str.++ " " ""))))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ (re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re ""))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
