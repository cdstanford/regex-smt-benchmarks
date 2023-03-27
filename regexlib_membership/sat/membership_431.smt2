;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(3[0-1]|2[0-9]|1[0-9]|0[1-9])[\/](Jan|JAN|Feb|FEB|Mar|MAR|Apr|APR|May|MAY|Jun|JUN|Jul|JUL|Aug|AUG|Sep|SEP|Oct|OCT|Nov|NOV|Dec|DEC)[\/]\d{4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "14/Jan/5842"
(define-fun Witness1 () String (str.++ "1" (str.++ "4" (str.++ "/" (str.++ "J" (str.++ "a" (str.++ "n" (str.++ "/" (str.++ "5" (str.++ "8" (str.++ "4" (str.++ "2" ""))))))))))))
;witness2: "29/Feb/5398"
(define-fun Witness2 () String (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "F" (str.++ "e" (str.++ "b" (str.++ "/" (str.++ "5" (str.++ "3" (str.++ "9" (str.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "3" "3") (re.range "0" "1"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "0" "0") (re.range "1" "9")))))(re.++ (re.range "/" "/")(re.++ (re.union (str.to_re (str.++ "J" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "A" (str.++ "N" ""))))(re.union (str.to_re (str.++ "F" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "F" (str.++ "E" (str.++ "B" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "R" ""))))(re.union (str.to_re (str.++ "A" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "R" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "Y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "N" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "L" ""))))(re.union (str.to_re (str.++ "A" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "A" (str.++ "U" (str.++ "G" ""))))(re.union (str.to_re (str.++ "S" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "S" (str.++ "E" (str.++ "P" ""))))(re.union (str.to_re (str.++ "O" (str.++ "c" (str.++ "t" ""))))(re.union (str.to_re (str.++ "O" (str.++ "C" (str.++ "T" ""))))(re.union (str.to_re (str.++ "N" (str.++ "o" (str.++ "v" ""))))(re.union (str.to_re (str.++ "N" (str.++ "O" (str.++ "V" ""))))(re.union (str.to_re (str.++ "D" (str.++ "e" (str.++ "c" "")))) (str.to_re (str.++ "D" (str.++ "E" (str.++ "C" "")))))))))))))))))))))))))))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
