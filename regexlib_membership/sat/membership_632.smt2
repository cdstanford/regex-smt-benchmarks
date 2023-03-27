;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-HJ-PR-Y]{2}([0][1-9]|[1-9][0-9])|[A-HJ-PR-Y]{1}([1-9]|[1-2][0-9]|30|31|33|40|44|55|50|60|66|70|77|80|88|90|99|111|121|123|222|321|333|444|555|666|777|888|999|100|200|300|400|500|600|700|800|900))[ ][A-HJ-PR-Z]{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "CR05 PZG"
(define-fun Witness1 () String (str.++ "C" (str.++ "R" (str.++ "0" (str.++ "5" (str.++ " " (str.++ "P" (str.++ "Z" (str.++ "G" "")))))))))
;witness2: "XK05 XYJ"
(define-fun Witness2 () String (str.++ "X" (str.++ "K" (str.++ "0" (str.++ "5" (str.++ " " (str.++ "X" (str.++ "Y" (str.++ "J" "")))))))))

(assert (= regexA (re.++ (re.union (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Y")))) (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "9") (re.range "0" "9")))) (re.++ (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Y"))) (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "2") (re.range "0" "9"))(re.union (str.to_re (str.++ "3" (str.++ "0" "")))(re.union (str.to_re (str.++ "3" (str.++ "1" "")))(re.union (str.to_re (str.++ "3" (str.++ "3" "")))(re.union (str.to_re (str.++ "4" (str.++ "0" "")))(re.union (str.to_re (str.++ "4" (str.++ "4" "")))(re.union (str.to_re (str.++ "5" (str.++ "5" "")))(re.union (str.to_re (str.++ "5" (str.++ "0" "")))(re.union (str.to_re (str.++ "6" (str.++ "0" "")))(re.union (str.to_re (str.++ "6" (str.++ "6" "")))(re.union (str.to_re (str.++ "7" (str.++ "0" "")))(re.union (str.to_re (str.++ "7" (str.++ "7" "")))(re.union (str.to_re (str.++ "8" (str.++ "0" "")))(re.union (str.to_re (str.++ "8" (str.++ "8" "")))(re.union (str.to_re (str.++ "9" (str.++ "0" "")))(re.union (str.to_re (str.++ "9" (str.++ "9" "")))(re.union (str.to_re (str.++ "1" (str.++ "1" (str.++ "1" ""))))(re.union (str.to_re (str.++ "1" (str.++ "2" (str.++ "1" ""))))(re.union (str.to_re (str.++ "1" (str.++ "2" (str.++ "3" ""))))(re.union (str.to_re (str.++ "2" (str.++ "2" (str.++ "2" ""))))(re.union (str.to_re (str.++ "3" (str.++ "2" (str.++ "1" ""))))(re.union (str.to_re (str.++ "3" (str.++ "3" (str.++ "3" ""))))(re.union (str.to_re (str.++ "4" (str.++ "4" (str.++ "4" ""))))(re.union (str.to_re (str.++ "5" (str.++ "5" (str.++ "5" ""))))(re.union (str.to_re (str.++ "6" (str.++ "6" (str.++ "6" ""))))(re.union (str.to_re (str.++ "7" (str.++ "7" (str.++ "7" ""))))(re.union (str.to_re (str.++ "8" (str.++ "8" (str.++ "8" ""))))(re.union (str.to_re (str.++ "9" (str.++ "9" (str.++ "9" ""))))(re.union (str.to_re (str.++ "1" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "2" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "3" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "4" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "5" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "6" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "7" (str.++ "0" (str.++ "0" ""))))(re.union (str.to_re (str.++ "8" (str.++ "0" (str.++ "0" "")))) (str.to_re (str.++ "9" (str.++ "0" (str.++ "0" "")))))))))))))))))))))))))))))))))))))))))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Z")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
