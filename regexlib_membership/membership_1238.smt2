;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((([0-1]?\d)|(2[0-8]))\/((0?\d)|(1[0-2])))|(29\/((0?[1,3-9])|(1[0-2])))|(30\/((0?[1,3-9])|(1[0-2])))|(31\/((0?[13578])|(1[0-2]))))\/((19\d{2})|([2-9]\d{3}))|(29\/0?2\/(((([2468][048])|([3579][26]))00)|(((19)|([2-9]\d))(([2468]0)|([02468][48])|([13579][26]))))))\s(([01]?\d)|(2[0-3]))(:[0-5]?\d){2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "29/02/1940 16:6:4"
(define-fun Witness1 () String (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "0" (str.++ "2" (str.++ "/" (str.++ "1" (str.++ "9" (str.++ "4" (str.++ "0" (str.++ " " (str.++ "1" (str.++ "6" (str.++ ":" (str.++ "6" (str.++ ":" (str.++ "4" ""))))))))))))))))))
;witness2: "29/0,/1994 23:46:8"
(define-fun Witness2 () String (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "0" (str.++ "," (str.++ "/" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "4" (str.++ " " (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "4" (str.++ "6" (str.++ ":" (str.++ "8" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))(re.++ (re.range "/" "/") (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "9" (str.++ "/" "")))) (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "," ",")(re.union (re.range "1" "1") (re.range "3" "9")))) (re.++ (re.range "1" "1") (re.range "0" "2"))))(re.union (re.++ (str.to_re (str.++ "3" (str.++ "0" (str.++ "/" "")))) (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "," ",")(re.union (re.range "1" "1") (re.range "3" "9")))) (re.++ (re.range "1" "1") (re.range "0" "2")))) (re.++ (str.to_re (str.++ "3" (str.++ "1" (str.++ "/" "")))) (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.range "0" "2")))))))(re.++ (re.range "/" "/") (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" ""))) ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))))) (re.++ (str.to_re (str.++ "2" (str.++ "9" (str.++ "/" ""))))(re.++ (re.opt (re.range "0" "0"))(re.++ (str.to_re (str.++ "2" (str.++ "/" ""))) (re.union (re.++ (re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))) (re.union (re.range "2" "2") (re.range "6" "6")))) (str.to_re (str.++ "0" (str.++ "0" "")))) (re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (re.++ (re.range "2" "9") (re.range "0" "9"))) (re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.range "0" "0"))(re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "4" "4") (re.range "8" "8"))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ ((_ re.loop 2 2) (re.++ (re.range ":" ":")(re.++ (re.opt (re.range "0" "5")) (re.range "0" "9")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
