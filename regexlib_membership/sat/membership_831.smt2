;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = For IP-Address:(?<First>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<Second>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<Third>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<Fourth>2[0-4]\d|25[0-5]|[01]?\d\d?)  For Number: (\+|\*{0,2})?(\d*)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "For IP-Address:09.02.99.171  For Number: 8"
(define-fun Witness1 () String (str.++ "F" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "I" (str.++ "P" (str.++ "-" (str.++ "A" (str.++ "d" (str.++ "d" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ ":" (str.++ "0" (str.++ "9" (str.++ "." (str.++ "0" (str.++ "2" (str.++ "." (str.++ "9" (str.++ "9" (str.++ "." (str.++ "1" (str.++ "7" (str.++ "1" (str.++ " " (str.++ " " (str.++ "F" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "N" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ ":" (str.++ " " (str.++ "8" "")))))))))))))))))))))))))))))))))))))))))))
;witness2: "For IP-Address:255.06.253.246  For Number: **9\u0083"
(define-fun Witness2 () String (str.++ "F" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "I" (str.++ "P" (str.++ "-" (str.++ "A" (str.++ "d" (str.++ "d" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ ":" (str.++ "2" (str.++ "5" (str.++ "5" (str.++ "." (str.++ "0" (str.++ "6" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "3" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "6" (str.++ " " (str.++ " " (str.++ "F" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "N" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ ":" (str.++ " " (str.++ "*" (str.++ "*" (str.++ "9" (str.++ "\u{83}" ""))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "F" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "I" (str.++ "P" (str.++ "-" (str.++ "A" (str.++ "d" (str.++ "d" (str.++ "r" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ ":" ""))))))))))))))))(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))(re.++ (str.to_re (str.++ " " (str.++ " " (str.++ "F" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "N" (str.++ "u" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" (str.++ ":" (str.++ " " "")))))))))))))))(re.++ (re.opt (re.union (re.range "+" "+") ((_ re.loop 0 2) (re.range "*" "*")))) (re.* (re.range "0" "9"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
