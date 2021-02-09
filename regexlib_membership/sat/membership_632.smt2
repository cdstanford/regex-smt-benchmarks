;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-HJ-PR-Y]{2}([0][1-9]|[1-9][0-9])|[A-HJ-PR-Y]{1}([1-9]|[1-2][0-9]|30|31|33|40|44|55|50|60|66|70|77|80|88|90|99|111|121|123|222|321|333|444|555|666|777|888|999|100|200|300|400|500|600|700|800|900))[ ][A-HJ-PR-Z]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "CR05 PZG"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "R" (seq.++ "0" (seq.++ "5" (seq.++ " " (seq.++ "P" (seq.++ "Z" (seq.++ "G" "")))))))))
;witness2: "XK05 XYJ"
(define-fun Witness2 () String (seq.++ "X" (seq.++ "K" (seq.++ "0" (seq.++ "5" (seq.++ " " (seq.++ "X" (seq.++ "Y" (seq.++ "J" "")))))))))

(assert (= regexA (re.++ (re.union (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Y")))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "9") (re.range "0" "9")))) (re.++ (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Y"))) (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "2") (re.range "0" "9"))(re.union (str.to_re (seq.++ "3" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "1" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "3" "")))(re.union (str.to_re (seq.++ "4" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "4" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "5" (seq.++ "5" "")))(re.union (str.to_re (seq.++ "5" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "6" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "6" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "7" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "7" (seq.++ "7" "")))(re.union (str.to_re (seq.++ "8" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "8" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "9" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "9" (seq.++ "9" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "1" (seq.++ "1" ""))))(re.union (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "1" ""))))(re.union (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "3" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "2" (seq.++ "2" ""))))(re.union (str.to_re (seq.++ "3" (seq.++ "2" (seq.++ "1" ""))))(re.union (str.to_re (seq.++ "3" (seq.++ "3" (seq.++ "3" ""))))(re.union (str.to_re (seq.++ "4" (seq.++ "4" (seq.++ "4" ""))))(re.union (str.to_re (seq.++ "5" (seq.++ "5" (seq.++ "5" ""))))(re.union (str.to_re (seq.++ "6" (seq.++ "6" (seq.++ "6" ""))))(re.union (str.to_re (seq.++ "7" (seq.++ "7" (seq.++ "7" ""))))(re.union (str.to_re (seq.++ "8" (seq.++ "8" (seq.++ "8" ""))))(re.union (str.to_re (seq.++ "9" (seq.++ "9" (seq.++ "9" ""))))(re.union (str.to_re (seq.++ "1" (seq.++ "0" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "2" (seq.++ "0" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "3" (seq.++ "0" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "4" (seq.++ "0" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "5" (seq.++ "0" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "7" (seq.++ "0" (seq.++ "0" ""))))(re.union (str.to_re (seq.++ "8" (seq.++ "0" (seq.++ "0" "")))) (str.to_re (seq.++ "9" (seq.++ "0" (seq.++ "0" "")))))))))))))))))))))))))))))))))))))))))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Z")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
