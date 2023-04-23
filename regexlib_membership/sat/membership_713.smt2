;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9][0-9][0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])\s{1}(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4598-12-08\u00A009:54,"
(define-fun Witness1 () String (str.++ "4" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "-" (str.++ "0" (str.++ "8" (str.++ "\u{a0}" (str.++ "0" (str.++ "9" (str.++ ":" (str.++ "5" (str.++ "4" (str.++ "," ""))))))))))))))))))
;witness2: "7177-12-18\u008523:29\u00D9f"
(define-fun Witness2 () String (str.++ "7" (str.++ "1" (str.++ "7" (str.++ "7" (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "-" (str.++ "1" (str.++ "8" (str.++ "\u{85}" (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "2" (str.++ "9" (str.++ "\u{d9}" (str.++ "f" "")))))))))))))))))))

(assert (= regexA (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9"))(re.union (re.++ (re.range "2" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
