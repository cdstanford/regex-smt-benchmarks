;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[NS]([0-8][0-9](\.[0-5]\d){2}|90(\.00){2})\040[EW]((0\d\d|1[0-7]\d)(\.[0-5]\d){2}|180(\.00){2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "N19.39.58 W008.04.53"
(define-fun Witness1 () String (seq.++ "N" (seq.++ "1" (seq.++ "9" (seq.++ "." (seq.++ "3" (seq.++ "9" (seq.++ "." (seq.++ "5" (seq.++ "8" (seq.++ " " (seq.++ "W" (seq.++ "0" (seq.++ "0" (seq.++ "8" (seq.++ "." (seq.++ "0" (seq.++ "4" (seq.++ "." (seq.++ "5" (seq.++ "3" "")))))))))))))))))))))
;witness2: "N90.00.00 E180.00.00"
(define-fun Witness2 () String (seq.++ "N" (seq.++ "9" (seq.++ "0" (seq.++ "." (seq.++ "0" (seq.++ "0" (seq.++ "." (seq.++ "0" (seq.++ "0" (seq.++ " " (seq.++ "E" (seq.++ "1" (seq.++ "8" (seq.++ "0" (seq.++ "." (seq.++ "0" (seq.++ "0" (seq.++ "." (seq.++ "0" (seq.++ "0" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "N" "N") (re.range "S" "S"))(re.++ (re.union (re.++ (re.range "0" "8")(re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.++ (re.range "." ".")(re.++ (re.range "0" "5") (re.range "0" "9")))))) (re.++ (str.to_re (seq.++ "9" (seq.++ "0" ""))) ((_ re.loop 2 2) (str.to_re (seq.++ "." (seq.++ "0" (seq.++ "0" "")))))))(re.++ (re.range " " " ")(re.++ (re.union (re.range "E" "E") (re.range "W" "W"))(re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0")(re.++ (re.range "0" "9") (re.range "0" "9"))) (re.++ (re.range "1" "1")(re.++ (re.range "0" "7") (re.range "0" "9")))) ((_ re.loop 2 2) (re.++ (re.range "." ".")(re.++ (re.range "0" "5") (re.range "0" "9"))))) (re.++ (str.to_re (seq.++ "1" (seq.++ "8" (seq.++ "0" "")))) ((_ re.loop 2 2) (str.to_re (seq.++ "." (seq.++ "0" (seq.++ "0" ""))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
