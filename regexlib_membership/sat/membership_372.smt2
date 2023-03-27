;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((((0[1-9])|(1\d)|(2[0-8]))\.((0[123456789])|(1[0-2])))|(((29)|(30))\.((0[13456789])|(1[0-2])))|((31)\.((0[13578])|(1[02]))))\.\d{4})|((29)\.(02)\.\d{2}(([02468][048])|([13579][26]))))(\s((0\d)|(1\d)|(2[0-3]))\:([0-5]\d)\:([0-5]\d)\.\d{7})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "31.08.8892\u008511:49:48.2899288"
(define-fun Witness1 () String (str.++ "3" (str.++ "1" (str.++ "." (str.++ "0" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "2" (str.++ "\u{85}" (str.++ "1" (str.++ "1" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ ":" (str.++ "4" (str.++ "8" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "8" ""))))))))))))))))))))))))))))
;witness2: "15.08.8881 02:53:49.0189890"
(define-fun Witness2 () String (str.++ "1" (str.++ "5" (str.++ "." (str.++ "0" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ " " (str.++ "0" (str.++ "2" (str.++ ":" (str.++ "5" (str.++ "3" (str.++ ":" (str.++ "4" (str.++ "9" (str.++ "." (str.++ "0" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "0" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))(re.++ (re.range "." ".") (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))))(re.union (re.++ (re.union (str.to_re (str.++ "2" (str.++ "9" ""))) (str.to_re (str.++ "3" (str.++ "0" ""))))(re.++ (re.range "." ".") (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2"))))) (re.++ (str.to_re (str.++ "3" (str.++ "1" "")))(re.++ (re.range "." ".") (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))))))(re.++ (re.range "." ".") ((_ re.loop 4 4) (re.range "0" "9")))) (re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.range "." ".")(re.++ (str.to_re (str.++ "0" (str.++ "2" "")))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))))))))(re.++ (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 7 7) (re.range "0" "9"))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
