;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?i)^((((0[1-9])|([12][0-9])|(3[01])) ((JAN)|(MAR)|(MAY)|(JUL)|(AUG)|(OCT)|(DEC)))|((((0[1-9])|([12][0-9])|(30)) ((APR)|(JUN)|(SEP)|(NOV)))|(((0[1-9])|([12][0-9])) FEB))) \d\d\d\d ((([0-1][0-9])|(2[0-3])):[0-5][0-9]:[0-5][0-9])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "18 fEB 9977 22:21:15"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "8" (seq.++ " " (seq.++ "f" (seq.++ "E" (seq.++ "B" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "7" (seq.++ " " (seq.++ "2" (seq.++ "2" (seq.++ ":" (seq.++ "2" (seq.++ "1" (seq.++ ":" (seq.++ "1" (seq.++ "5" "")))))))))))))))))))))
;witness2: "19 FeB 7818 21:28:09"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "9" (seq.++ " " (seq.++ "F" (seq.++ "e" (seq.++ "B" (seq.++ " " (seq.++ "7" (seq.++ "8" (seq.++ "1" (seq.++ "8" (seq.++ " " (seq.++ "2" (seq.++ "1" (seq.++ ":" (seq.++ "2" (seq.++ "8" (seq.++ ":" (seq.++ "0" (seq.++ "9" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range " " " ") (re.union (str.to_re (seq.++ "j" (seq.++ "a" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "y" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "u" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "u" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "c" (seq.++ "t" "")))) (str.to_re (seq.++ "d" (seq.++ "e" (seq.++ "c" "")))))))))))) (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (seq.++ "3" (seq.++ "0" "")))))(re.++ (re.range " " " ") (re.union (str.to_re (seq.++ "a" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "s" (seq.++ "e" (seq.++ "p" "")))) (str.to_re (seq.++ "n" (seq.++ "o" (seq.++ "v" ""))))))))) (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9"))) (str.to_re (seq.++ " " (seq.++ "f" (seq.++ "e" (seq.++ "b" ""))))))))(re.++ (re.range " " " ")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range " " " ")(re.++ (re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
