;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((1[6789]|[2-9][0-9])[0-9]{2}-(0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))$|^((1[6789]|[2-9][0-9])[0-9]{2}-(0[469]|11)-(0[1-9]|[12][0-9]|30))$|^((16|[248][048]|[3579][26])00)|(1[6789]|[2-9][0-9])(0[48]|[13579][26]|[2468][048])-02-(0[1-9]|1[0-9]|2[0-9])$|^(1[6789]|[2-9][0-9])[0-9]{2}-02-(0[1-9]|1[0-9]|2[0-8])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xE9008-02-18"
(define-fun Witness1 () String (str.++ "\u{0e}" (str.++ "9" (str.++ "0" (str.++ "0" (str.++ "8" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "1" (str.++ "8" ""))))))))))))
;witness2: "1908-02-28"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" (str.++ "2" (str.++ "8" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.range "1" "1") (re.range "6" "9")) (re.++ (re.range "2" "9") (re.range "0" "9")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.range "1" "1") (re.range "6" "9")) (re.++ (re.range "2" "9") (re.range "0" "9")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.range "-" "-") (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" "")))))))))) (str.to_re "")))(re.union (re.++ (str.to_re "") (re.++ (re.union (str.to_re (str.++ "1" (str.++ "6" "")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4") (re.range "8" "8"))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re (str.++ "0" (str.++ "0" "")))))(re.union (re.++ (re.union (re.++ (re.range "1" "1") (re.range "6" "9")) (re.++ (re.range "2" "9") (re.range "0" "9")))(re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))) (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))))(re.++ (str.to_re (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" "")))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "9")))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "1") (re.range "6" "9")) (re.++ (re.range "2" "9") (re.range "0" "9")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (str.to_re (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "-" "")))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
