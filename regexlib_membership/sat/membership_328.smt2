;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])(?:.\d{7})?[+|-](0[0-9]|1[0-2]):(00|15|30|45)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "v\u00E98528-11-18T18:37:39Q0899088-08:15"
(define-fun Witness1 () String (seq.++ "v" (seq.++ "\xe9" (seq.++ "8" (seq.++ "5" (seq.++ "2" (seq.++ "8" (seq.++ "-" (seq.++ "1" (seq.++ "1" (seq.++ "-" (seq.++ "1" (seq.++ "8" (seq.++ "T" (seq.++ "1" (seq.++ "8" (seq.++ ":" (seq.++ "3" (seq.++ "7" (seq.++ ":" (seq.++ "3" (seq.++ "9" (seq.++ "Q" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "0" (seq.++ "8" (seq.++ ":" (seq.++ "1" (seq.++ "5" ""))))))))))))))))))))))))))))))))))))
;witness2: "4299-09-08T18:25:29P2997880|08:30"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "0" (seq.++ "9" (seq.++ "-" (seq.++ "0" (seq.++ "8" (seq.++ "T" (seq.++ "1" (seq.++ "8" (seq.++ ":" (seq.++ "2" (seq.++ "5" (seq.++ ":" (seq.++ "2" (seq.++ "9" (seq.++ "P" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "|" (seq.++ "0" (seq.++ "8" (seq.++ ":" (seq.++ "3" (seq.++ "0" ""))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "T" "T")(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) ((_ re.loop 7 7) (re.range "0" "9"))))(re.++ (re.union (re.range "+" "+")(re.union (re.range "-" "-") (re.range "|" "|")))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range ":" ":") (re.union (str.to_re (seq.++ "0" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "5" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "0" ""))) (str.to_re (seq.++ "4" (seq.++ "5" "")))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
