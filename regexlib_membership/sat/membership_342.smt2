;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-3]{1}[0-9]{1}[ ]{1}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec){1}[ ]{1}[0-9]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "10 Oct 29"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "0" (seq.++ " " (seq.++ "O" (seq.++ "c" (seq.++ "t" (seq.++ " " (seq.++ "2" (seq.++ "9" ""))))))))))
;witness2: "01 Jun 28"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "1" (seq.++ " " (seq.++ "J" (seq.++ "u" (seq.++ "n" (seq.++ " " (seq.++ "2" (seq.++ "8" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "3")(re.++ (re.range "0" "9")(re.++ (re.range " " " ")(re.++ (re.union (str.to_re (seq.++ "J" (seq.++ "a" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "e" (seq.++ "b" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "a" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "a" (seq.++ "y" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "u" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "u" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "e" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "c" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "o" (seq.++ "v" ""))))(re.union (str.to_re (seq.++ "D" (seq.++ "e" (seq.++ "c" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "A" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "E" (seq.++ "B" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "A" (seq.++ "R" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "P" (seq.++ "R" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "A" (seq.++ "Y" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "U" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "U" (seq.++ "L" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "U" (seq.++ "G" ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "E" (seq.++ "P" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "C" (seq.++ "T" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "O" (seq.++ "V" ""))))(re.union (str.to_re (seq.++ "D" (seq.++ "E" (seq.++ "C" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "a" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "f" (seq.++ "e" (seq.++ "b" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "y" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "u" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "u" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "s" (seq.++ "e" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "c" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "n" (seq.++ "o" (seq.++ "v" "")))) (str.to_re (seq.++ "d" (seq.++ "e" (seq.++ "c" "")))))))))))))))))))))))))))))))))))))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
