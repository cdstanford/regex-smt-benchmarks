;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{1,}[a-z]{1,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,}[A-Z]{0,}[a-z]{0,})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "IwTwElnqipijUadzisXVOXQLFZHHPr"
(define-fun Witness1 () String (str.++ "I" (str.++ "w" (str.++ "T" (str.++ "w" (str.++ "E" (str.++ "l" (str.++ "n" (str.++ "q" (str.++ "i" (str.++ "p" (str.++ "i" (str.++ "j" (str.++ "U" (str.++ "a" (str.++ "d" (str.++ "z" (str.++ "i" (str.++ "s" (str.++ "X" (str.++ "V" (str.++ "O" (str.++ "X" (str.++ "Q" (str.++ "L" (str.++ "F" (str.++ "Z" (str.++ "H" (str.++ "H" (str.++ "P" (str.++ "r" "")))))))))))))))))))))))))))))))
;witness2: "TUBywXaFyZkMXVTBRfnPT"
(define-fun Witness2 () String (str.++ "T" (str.++ "U" (str.++ "B" (str.++ "y" (str.++ "w" (str.++ "X" (str.++ "a" (str.++ "F" (str.++ "y" (str.++ "Z" (str.++ "k" (str.++ "M" (str.++ "X" (str.++ "V" (str.++ "T" (str.++ "B" (str.++ "R" (str.++ "f" (str.++ "n" (str.++ "P" (str.++ "T" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.range "A" "Z"))(re.++ (re.+ (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z"))(re.++ (re.* (re.range "a" "z"))(re.++ (re.* (re.range "A" "Z")) (re.* (re.range "a" "z"))))))))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
