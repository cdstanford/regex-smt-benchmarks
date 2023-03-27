;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-3]{1}[0-9]{1}(jan|JAN|feb|FEB|mar|MAR|apr|APR|may|MAY|jun|JUN|jul|JUL|aug|AUG|sep|SEP|oct|OCT|nov|NOV|dec|DEC){1}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E4\u00EC38apr"
(define-fun Witness1 () String (str.++ "\u{e4}" (str.++ "\u{ec}" (str.++ "3" (str.++ "8" (str.++ "a" (str.++ "p" (str.++ "r" ""))))))))
;witness2: "VXJ21MAY"
(define-fun Witness2 () String (str.++ "V" (str.++ "X" (str.++ "J" (str.++ "2" (str.++ "1" (str.++ "M" (str.++ "A" (str.++ "Y" "")))))))))

(assert (= regexA (re.++ (re.range "0" "3")(re.++ (re.range "0" "9") (re.union (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "A" (str.++ "N" ""))))(re.union (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "F" (str.++ "E" (str.++ "B" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "R" ""))))(re.union (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "R" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "M" (str.++ "A" (str.++ "Y" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "N" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "L" ""))))(re.union (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "A" (str.++ "U" (str.++ "G" ""))))(re.union (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "S" (str.++ "E" (str.++ "P" ""))))(re.union (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" ""))))(re.union (str.to_re (str.++ "O" (str.++ "C" (str.++ "T" ""))))(re.union (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" ""))))(re.union (str.to_re (str.++ "N" (str.++ "O" (str.++ "V" ""))))(re.union (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))) (str.to_re (str.++ "D" (str.++ "E" (str.++ "C" "")))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
