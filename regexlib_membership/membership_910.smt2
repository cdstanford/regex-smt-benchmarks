;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i)^((((0[1-9])|([12][0-9])|(3[01])) ((JAN)|(MAR)|(MAY)|(JUL)|(AUG)|(OCT)|(DEC)))|((((0[1-9])|([12][0-9])|(30)) ((APR)|(JUN)|(SEP)|(NOV)))|(((0[1-9])|([12][0-9])) FEB))) \d\d\d\d ((([0-1][0-9])|(2[0-3])):[0-5][0-9]:[0-5][0-9])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "18 fEB 9977 22:21:15"
(define-fun Witness1 () String (str.++ "1" (str.++ "8" (str.++ " " (str.++ "f" (str.++ "E" (str.++ "B" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "7" (str.++ " " (str.++ "2" (str.++ "2" (str.++ ":" (str.++ "2" (str.++ "1" (str.++ ":" (str.++ "1" (str.++ "5" "")))))))))))))))))))))
;witness2: "19 FeB 7818 21:28:09"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ " " (str.++ "F" (str.++ "e" (str.++ "B" (str.++ " " (str.++ "7" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ " " (str.++ "2" (str.++ "1" (str.++ ":" (str.++ "2" (str.++ "8" (str.++ ":" (str.++ "0" (str.++ "9" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range " " " ") (re.union (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" "")))) (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))))))))))) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))(re.++ (re.range " " " ") (re.union (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" "")))) (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" ""))))))))) (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9"))) (str.to_re (str.++ " " (str.++ "f" (str.++ "e" (str.++ "b" ""))))))))(re.++ (re.range " " " ")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range " " " ")(re.++ (re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
