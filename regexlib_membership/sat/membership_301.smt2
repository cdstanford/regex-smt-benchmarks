;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\d{2}(([02468][048])|([13579][26]))[-]?((((0?[13578])|(1[02]))[-]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[-]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[-]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[-]?((((0?[13578])|(1[02]))[-]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[-]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[-]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s((([0-1]?[0-9])|([2][0-3]))\:([0-5][0-9])))?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9882-1109"
(define-fun Witness1 () String (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "2" (str.++ "-" (str.++ "1" (str.++ "1" (str.++ "0" (str.++ "9" ""))))))))))
;witness2: "2069-12-4"
(define-fun Witness2 () String (str.++ "2" (str.++ "0" (str.++ "6" (str.++ "9" (str.++ "-" (str.++ "1" (str.++ "2" (str.++ "-" (str.++ "4" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" ""))))))) (re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "2" "2")(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9"))))))))))) (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "1" "3")(re.union (re.range "5" "7") (re.range "9" "9")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "0" "1")(re.union (re.range "3" "5") (re.range "7" "9")))))(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (str.++ "1" (str.++ "1" ""))))(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" ""))))))) (re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "2" "2")(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))))))))))))(re.++ (re.opt (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
