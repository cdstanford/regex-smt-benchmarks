;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((((0[1-9])|(1\d)|(2[0-8]))\/((0[1-9])|(1[0-2])))|((31\/((0[13578])|(1[02])))|((29|30)\/((0[1,3-9])|(1[0-2])))))\/((20[0-9][0-9])|(19[0-9][0-9])))|((29\/02\/(19|20)(([02468][048])|([13579][26]))))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "29/11/2090"
(define-fun Witness1 () String (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "1" (str.++ "1" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "9" (str.++ "0" "")))))))))))
;witness2: "\u0091B\u00B829/02/1996"
(define-fun Witness2 () String (str.++ "\u{91}" (str.++ "B" (str.++ "\u{b8}" (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "0" (str.++ "2" (str.++ "/" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "6" ""))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))(re.++ (re.range "/" "/") (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))))) (re.union (re.++ (str.to_re (str.++ "3" (str.++ "1" (str.++ "/" "")))) (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))) (re.++ (re.union (str.to_re (str.++ "2" (str.++ "9" ""))) (str.to_re (str.++ "3" (str.++ "0" ""))))(re.++ (re.range "/" "/") (re.union (re.++ (re.range "0" "0") (re.union (re.range "," ",")(re.union (re.range "1" "1") (re.range "3" "9")))) (re.++ (re.range "1" "1") (re.range "0" "2")))))))(re.++ (re.range "/" "/") (re.union (re.++ (str.to_re (str.++ "2" (str.++ "0" "")))(re.++ (re.range "0" "9") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "1" (str.++ "9" "")))(re.++ (re.range "0" "9") (re.range "0" "9"))))))) (re.++ (re.++ (str.to_re (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "0" (str.++ "2" (str.++ "/" "")))))))(re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (str.to_re (str.++ "2" (str.++ "0" "")))) (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
