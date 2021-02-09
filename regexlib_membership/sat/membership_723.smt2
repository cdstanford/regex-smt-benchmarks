;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (15(8[48]|9[26]))|((1[6-9]|[2-9]\d)(0[48]|[13579][26]|[2468][048]))|(([2468][048]|16|3579[26])00)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1592"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "5" (seq.++ "9" (seq.++ "2" "")))))
;witness2: "8168."
(define-fun Witness2 () String (seq.++ "8" (seq.++ "1" (seq.++ "6" (seq.++ "8" (seq.++ "." ""))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "1" (seq.++ "5" ""))) (re.union (re.++ (re.range "8" "8") (re.union (re.range "4" "4") (re.range "8" "8"))) (re.++ (re.range "9" "9") (re.union (re.range "2" "2") (re.range "6" "6")))))(re.union (re.++ (re.union (re.++ (re.range "1" "1") (re.range "6" "9")) (re.++ (re.range "2" "9") (re.range "0" "9"))) (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))) (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))))) (re.++ (re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (str.to_re (seq.++ "1" (seq.++ "6" ""))) (re.++ (str.to_re (seq.++ "3" (seq.++ "5" (seq.++ "7" (seq.++ "9" ""))))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re (seq.++ "0" (seq.++ "0" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
