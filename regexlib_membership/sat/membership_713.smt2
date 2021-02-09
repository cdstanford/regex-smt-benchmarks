;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9][0-9][0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])\s{1}(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4598-12-08\u00A009:54,"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "1" (seq.++ "2" (seq.++ "-" (seq.++ "0" (seq.++ "8" (seq.++ "\xa0" (seq.++ "0" (seq.++ "9" (seq.++ ":" (seq.++ "5" (seq.++ "4" (seq.++ "," ""))))))))))))))))))
;witness2: "7177-12-18\u008523:29\u00D9f"
(define-fun Witness2 () String (seq.++ "7" (seq.++ "1" (seq.++ "7" (seq.++ "7" (seq.++ "-" (seq.++ "1" (seq.++ "2" (seq.++ "-" (seq.++ "1" (seq.++ "8" (seq.++ "\x85" (seq.++ "2" (seq.++ "3" (seq.++ ":" (seq.++ "2" (seq.++ "9" (seq.++ "\xd9" (seq.++ "f" "")))))))))))))))))))

(assert (= regexA (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
