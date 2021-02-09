;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:J(anuary|u(ne|ly))|February|Ma(rch|y)|A(pril|ugust)|(((Sept|Nov|Dec)em)|Octo)ber)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "March"
(define-fun Witness1 () String (seq.++ "M" (seq.++ "a" (seq.++ "r" (seq.++ "c" (seq.++ "h" ""))))))
;witness2: "December"
(define-fun Witness2 () String (seq.++ "D" (seq.++ "e" (seq.++ "c" (seq.++ "e" (seq.++ "m" (seq.++ "b" (seq.++ "e" (seq.++ "r" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "J" "J") (re.union (str.to_re (seq.++ "a" (seq.++ "n" (seq.++ "u" (seq.++ "a" (seq.++ "r" (seq.++ "y" ""))))))) (re.++ (re.range "u" "u") (re.union (str.to_re (seq.++ "n" (seq.++ "e" ""))) (str.to_re (seq.++ "l" (seq.++ "y" "")))))))(re.union (str.to_re (seq.++ "F" (seq.++ "e" (seq.++ "b" (seq.++ "r" (seq.++ "u" (seq.++ "a" (seq.++ "r" (seq.++ "y" "")))))))))(re.union (re.++ (str.to_re (seq.++ "M" (seq.++ "a" ""))) (re.union (str.to_re (seq.++ "r" (seq.++ "c" (seq.++ "h" "")))) (re.range "y" "y")))(re.union (re.++ (re.range "A" "A") (re.union (str.to_re (seq.++ "p" (seq.++ "r" (seq.++ "i" (seq.++ "l" ""))))) (str.to_re (seq.++ "u" (seq.++ "g" (seq.++ "u" (seq.++ "s" (seq.++ "t" "")))))))) (re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "S" (seq.++ "e" (seq.++ "p" (seq.++ "t" "")))))(re.union (str.to_re (seq.++ "N" (seq.++ "o" (seq.++ "v" "")))) (str.to_re (seq.++ "D" (seq.++ "e" (seq.++ "c" "")))))) (str.to_re (seq.++ "e" (seq.++ "m" "")))) (str.to_re (seq.++ "O" (seq.++ "c" (seq.++ "t" (seq.++ "o" "")))))) (str.to_re (seq.++ "b" (seq.++ "e" (seq.++ "r" ""))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
