;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z0-9]+([a-zA-Z0-9\-\.]+)?\.(com|org|net|mil|edu|COM|ORG|NET|MIL|EDU)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "qhu-f.edu"
(define-fun Witness1 () String (seq.++ "q" (seq.++ "h" (seq.++ "u" (seq.++ "-" (seq.++ "f" (seq.++ "." (seq.++ "e" (seq.++ "d" (seq.++ "u" ""))))))))))
;witness2: "Nlb.edu"
(define-fun Witness2 () String (seq.++ "N" (seq.++ "l" (seq.++ "b" (seq.++ "." (seq.++ "e" (seq.++ "d" (seq.++ "u" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.opt (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "." ".")(re.++ (re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "r" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "i" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "e" (seq.++ "d" (seq.++ "u" ""))))(re.union (str.to_re (seq.++ "C" (seq.++ "O" (seq.++ "M" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "R" (seq.++ "G" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "E" (seq.++ "T" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "I" (seq.++ "L" "")))) (str.to_re (seq.++ "E" (seq.++ "D" (seq.++ "U" ""))))))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
