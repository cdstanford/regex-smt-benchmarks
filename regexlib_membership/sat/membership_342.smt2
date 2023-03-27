;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-3]{1}[0-9]{1}[ ]{1}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec){1}[ ]{1}[0-9]{2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "10 Oct 29"
(define-fun Witness1 () String (str.++ "1" (str.++ "0" (str.++ " " (str.++ "O" (str.++ "c" (str.++ "t" (str.++ " " (str.++ "2" (str.++ "9" ""))))))))))
;witness2: "01 Jun 28"
(define-fun Witness2 () String (str.++ "0" (str.++ "1" (str.++ " " (str.++ "J" (str.++ "u" (str.++ "n" (str.++ " " (str.++ "2" (str.++ "8" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "3")(re.++ (re.range "0" "9")(re.++ (re.range " " " ")(re.++ (re.union (str.to_re (str.++ "J" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "F" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "A" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "M" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "A" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "S" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "O" (str.++ "c" (str.++ "t" ""))))(re.union (str.to_re (str.++ "N" (str.++ "o" (str.++ "v" ""))))(re.union (str.to_re (str.++ "D" (str.++ "e" (str.++ "c" ""))))(re.union (str.to_re (str.++ "J" (str.++ "A" (str.++ "N" ""))))(re.union (str.to_re (str.++ "F" (str.++ "E" (str.++ "B" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "R" ""))))(re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "R" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "Y" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "N" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "L" ""))))(re.union (str.to_re (str.++ "A" (str.++ "U" (str.++ "G" ""))))(re.union (str.to_re (str.++ "S" (str.++ "E" (str.++ "P" ""))))(re.union (str.to_re (str.++ "O" (str.++ "C" (str.++ "T" ""))))(re.union (str.to_re (str.++ "N" (str.++ "O" (str.++ "V" ""))))(re.union (str.to_re (str.++ "D" (str.++ "E" (str.++ "C" ""))))(re.union (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" ""))))(re.union (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))) (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))))))))))))))))))))))))))))))))))))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
