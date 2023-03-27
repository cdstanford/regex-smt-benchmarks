;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|COM|ORG|NET|MIL|EDU)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-2.EDU"
(define-fun Witness1 () String (str.++ "-" (str.++ "2" (str.++ "." (str.++ "E" (str.++ "D" (str.++ "U" "")))))))
;witness2: "9.NET"
(define-fun Witness2 () String (str.++ "9" (str.++ "." (str.++ "N" (str.++ "E" (str.++ "T" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ (re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "m" ""))))(re.union (str.to_re (str.++ "o" (str.++ "r" (str.++ "g" ""))))(re.union (str.to_re (str.++ "n" (str.++ "e" (str.++ "t" ""))))(re.union (str.to_re (str.++ "m" (str.++ "i" (str.++ "l" ""))))(re.union (str.to_re (str.++ "e" (str.++ "d" (str.++ "u" ""))))(re.union (str.to_re (str.++ "C" (str.++ "O" (str.++ "M" ""))))(re.union (str.to_re (str.++ "O" (str.++ "R" (str.++ "G" ""))))(re.union (str.to_re (str.++ "N" (str.++ "E" (str.++ "T" ""))))(re.union (str.to_re (str.++ "M" (str.++ "I" (str.++ "L" "")))) (str.to_re (str.++ "E" (str.++ "D" (str.++ "U" ""))))))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
