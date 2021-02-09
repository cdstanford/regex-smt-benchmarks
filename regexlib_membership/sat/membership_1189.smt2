;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (0[1-9]|[12][0-9]|3[01])\s(J(anuary|uly)|Ma(rch|y)|August|(Octo|Decem)ber)\s[1-9][0-9]{3}|
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (re.++ (re.range "J" "J") (re.union (str.to_re (seq.++ "a" (seq.++ "n" (seq.++ "u" (seq.++ "a" (seq.++ "r" (seq.++ "y" ""))))))) (str.to_re (seq.++ "u" (seq.++ "l" (seq.++ "y" ""))))))(re.union (re.++ (str.to_re (seq.++ "M" (seq.++ "a" ""))) (re.union (str.to_re (seq.++ "r" (seq.++ "c" (seq.++ "h" "")))) (re.range "y" "y")))(re.union (str.to_re (seq.++ "A" (seq.++ "u" (seq.++ "g" (seq.++ "u" (seq.++ "s" (seq.++ "t" ""))))))) (re.++ (re.union (str.to_re (seq.++ "O" (seq.++ "c" (seq.++ "t" (seq.++ "o" ""))))) (str.to_re (seq.++ "D" (seq.++ "e" (seq.++ "c" (seq.++ "e" (seq.++ "m" ""))))))) (str.to_re (seq.++ "b" (seq.++ "e" (seq.++ "r" ""))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "1" "9") ((_ re.loop 3 3) (re.range "0" "9"))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
