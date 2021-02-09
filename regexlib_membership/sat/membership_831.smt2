;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = For IP-Address:(?<First>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<Second>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<Third>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<Fourth>2[0-4]\d|25[0-5]|[01]?\d\d?)  For Number: (\+|\*{0,2})?(\d*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "For IP-Address:09.02.99.171  For Number: 8"
(define-fun Witness1 () String (seq.++ "F" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "I" (seq.++ "P" (seq.++ "-" (seq.++ "A" (seq.++ "d" (seq.++ "d" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ ":" (seq.++ "0" (seq.++ "9" (seq.++ "." (seq.++ "0" (seq.++ "2" (seq.++ "." (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "1" (seq.++ "7" (seq.++ "1" (seq.++ " " (seq.++ " " (seq.++ "F" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "N" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ " " (seq.++ "8" "")))))))))))))))))))))))))))))))))))))))))))
;witness2: "For IP-Address:255.06.253.246  For Number: **9\u0083"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "I" (seq.++ "P" (seq.++ "-" (seq.++ "A" (seq.++ "d" (seq.++ "d" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ ":" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "." (seq.++ "0" (seq.++ "6" (seq.++ "." (seq.++ "2" (seq.++ "5" (seq.++ "3" (seq.++ "." (seq.++ "2" (seq.++ "4" (seq.++ "6" (seq.++ " " (seq.++ " " (seq.++ "F" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "N" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ " " (seq.++ "*" (seq.++ "*" (seq.++ "9" (seq.++ "\x83" ""))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "F" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "I" (seq.++ "P" (seq.++ "-" (seq.++ "A" (seq.++ "d" (seq.++ "d" (seq.++ "r" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ ":" ""))))))))))))))))(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))(re.++ (str.to_re (seq.++ " " (seq.++ " " (seq.++ "F" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "N" (seq.++ "u" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ " " "")))))))))))))))(re.++ (re.opt (re.union (re.range "+" "+") ((_ re.loop 0 2) (re.range "*" "*")))) (re.* (re.range "0" "9"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
