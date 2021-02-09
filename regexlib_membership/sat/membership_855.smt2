;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{1,}[a-z]{1,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "IwTwElnqipijUadzisXVOXQLFZHHPr"
(define-fun Witness1 () String (seq.++ "I" (seq.++ "w" (seq.++ "T" (seq.++ "w" (seq.++ "E" (seq.++ "l" (seq.++ "n" (seq.++ "q" (seq.++ "i" (seq.++ "p" (seq.++ "i" (seq.++ "j" (seq.++ "U" (seq.++ "a" (seq.++ "d" (seq.++ "z" (seq.++ "i" (seq.++ "s" (seq.++ "X" (seq.++ "V" (seq.++ "O" (seq.++ "X" (seq.++ "Q" (seq.++ "L" (seq.++ "F" (seq.++ "Z" (seq.++ "H" (seq.++ "H" (seq.++ "P" (seq.++ "r" "")))))))))))))))))))))))))))))))
;witness2: "TUBywXaFyZkMXVTBRfnPT"
(define-fun Witness2 () String (seq.++ "T" (seq.++ "U" (seq.++ "B" (seq.++ "y" (seq.++ "w" (seq.++ "X" (seq.++ "a" (seq.++ "F" (seq.++ "y" (seq.++ "Z" (seq.++ "k" (seq.++ "M" (seq.++ "X" (seq.++ "V" (seq.++ "T" (seq.++ "B" (seq.++ "R" (seq.++ "f" (seq.++ "n" (seq.++ "P" (seq.++ "T" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.range "A" "Z"))(re.++ (re.+ (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z")) (re.* (re.range "a" "z"))))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
