;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-3]{1}[0-9]{1}(jan|JAN|feb|FEB|mar|MAR|apr|APR|may|MAY|jun|JUN|jul|JUL|aug|AUG|sep|SEP|oct|OCT|nov|NOV|dec|DEC){1}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E4\u00EC38apr"
(define-fun Witness1 () String (seq.++ "\xe4" (seq.++ "\xec" (seq.++ "3" (seq.++ "8" (seq.++ "a" (seq.++ "p" (seq.++ "r" ""))))))))
;witness2: "VXJ21MAY"
(define-fun Witness2 () String (seq.++ "V" (seq.++ "X" (seq.++ "J" (seq.++ "2" (seq.++ "1" (seq.++ "M" (seq.++ "A" (seq.++ "Y" "")))))))))

(assert (= regexA (re.++ (re.range "0" "3")(re.++ (re.range "0" "9") (re.union (str.to_re (seq.++ "j" (seq.++ "a" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "A" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "f" (seq.++ "e" (seq.++ "b" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "E" (seq.++ "B" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "A" (seq.++ "R" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "P" (seq.++ "R" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "y" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "A" (seq.++ "Y" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "U" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "u" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "U" (seq.++ "L" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "u" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "U" (seq.++ "G" ""))))(re.union (str.to_re (seq.++ "s" (seq.++ "e" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "E" (seq.++ "P" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "c" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "C" (seq.++ "T" ""))))(re.union (str.to_re (seq.++ "n" (seq.++ "o" (seq.++ "v" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "O" (seq.++ "V" ""))))(re.union (str.to_re (seq.++ "d" (seq.++ "e" (seq.++ "c" "")))) (str.to_re (seq.++ "D" (seq.++ "E" (seq.++ "C" "")))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
