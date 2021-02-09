;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1][0-9]|2[0-3]){1}:([0-5][0-9]){1}:([0-5][0-9]){1},([0-9][0-9][0-9]){1} --> ([0-1][0-9]|2[0-3]){1}:([0-5][0-9]){1}:([0-5][0-9]){1},([0-9][0-9][0-9]){1}(.*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "21:18:52,884 --> 23:11:09,552A"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "1" (seq.++ ":" (seq.++ "1" (seq.++ "8" (seq.++ ":" (seq.++ "5" (seq.++ "2" (seq.++ "," (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ " " (seq.++ "-" (seq.++ "-" (seq.++ ">" (seq.++ " " (seq.++ "2" (seq.++ "3" (seq.++ ":" (seq.++ "1" (seq.++ "1" (seq.++ ":" (seq.++ "0" (seq.++ "9" (seq.++ "," (seq.++ "5" (seq.++ "5" (seq.++ "2" (seq.++ "A" "")))))))))))))))))))))))))))))))
;witness2: "21:49:03,898 --> 23:37:45,676\u0083"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "1" (seq.++ ":" (seq.++ "4" (seq.++ "9" (seq.++ ":" (seq.++ "0" (seq.++ "3" (seq.++ "," (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "-" (seq.++ "-" (seq.++ ">" (seq.++ " " (seq.++ "2" (seq.++ "3" (seq.++ ":" (seq.++ "3" (seq.++ "7" (seq.++ ":" (seq.++ "4" (seq.++ "5" (seq.++ "," (seq.++ "6" (seq.++ "7" (seq.++ "6" (seq.++ "\x83" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ (re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.++ (str.to_re (seq.++ " " (seq.++ "-" (seq.++ "-" (seq.++ ">" (seq.++ " " ""))))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range "," ",")(re.++ (re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re ""))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
