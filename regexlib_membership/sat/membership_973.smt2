;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-2]) ([0-1][0-9]|2[0-4]):([0-4][0-9]|5[0-9]):([0-4][0-9]|5[0-9])$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "7918-12-30 09:51:59"
(define-fun Witness1 () String (str.++ "7" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "-" (str.++ "3" (str.++ "0" (str.++ " " (str.++ "0" (str.++ "9" (str.++ ":" (str.++ "5" (str.++ "1" (str.++ ":" (str.++ "5" (str.++ "9" ""))))))))))))))))))))
;witness2: "5995-12-30 22:51:24"
(define-fun Witness2 () String (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "-" (str.++ "3" (str.++ "0" (str.++ " " (str.++ "2" (str.++ "2" (str.++ ":" (str.++ "5" (str.++ "1" (str.++ ":" (str.++ "2" (str.++ "4" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "2"))))(re.++ (re.range " " " ")(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "4")))(re.++ (re.range ":" ":")(re.++ (re.union (re.++ (re.range "0" "4") (re.range "0" "9")) (re.++ (re.range "5" "5") (re.range "0" "9")))(re.++ (re.range ":" ":")(re.++ (re.union (re.++ (re.range "0" "4") (re.range "0" "9")) (re.++ (re.range "5" "5") (re.range "0" "9"))) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
