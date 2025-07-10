;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:J(anuary|u(ne|ly))|February|Ma(rch|y)|A(pril|ugust)|(((Sept|Nov|Dec)em)|Octo)ber)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "March"
(define-fun Witness1 () String (str.++ "M" (str.++ "a" (str.++ "r" (str.++ "c" (str.++ "h" ""))))))
;witness2: "December"
(define-fun Witness2 () String (str.++ "D" (str.++ "e" (str.++ "c" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "J" "J") (re.union (str.to_re (str.++ "a" (str.++ "n" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))) (re.++ (re.range "u" "u") (re.union (str.to_re (str.++ "n" (str.++ "e" ""))) (str.to_re (str.++ "l" (str.++ "y" "")))))))(re.union (str.to_re (str.++ "F" (str.++ "e" (str.++ "b" (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" "")))))))))(re.union (re.++ (str.to_re (str.++ "M" (str.++ "a" ""))) (re.union (str.to_re (str.++ "r" (str.++ "c" (str.++ "h" "")))) (re.range "y" "y")))(re.union (re.++ (re.range "A" "A") (re.union (str.to_re (str.++ "p" (str.++ "r" (str.++ "i" (str.++ "l" ""))))) (str.to_re (str.++ "u" (str.++ "g" (str.++ "u" (str.++ "s" (str.++ "t" "")))))))) (re.++ (re.union (re.++ (re.union (str.to_re (str.++ "S" (str.++ "e" (str.++ "p" (str.++ "t" "")))))(re.union (str.to_re (str.++ "N" (str.++ "o" (str.++ "v" "")))) (str.to_re (str.++ "D" (str.++ "e" (str.++ "c" "")))))) (str.to_re (str.++ "e" (str.++ "m" "")))) (str.to_re (str.++ "O" (str.++ "c" (str.++ "t" (str.++ "o" "")))))) (str.to_re (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
