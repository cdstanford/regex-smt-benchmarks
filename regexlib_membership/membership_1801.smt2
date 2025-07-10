;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((25[0-5]|2[0-4][0-9]|19[0-1]|19[3-9]|18[0-9]|17[0-1]|17[3-9]|1[3-6][0-9]|12[8-9]|12[0-6]|1[0-1][0-9]|1[1-9]|[2-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9]))|(192\.(25[0-5]|2[0-4][0-9]|16[0-7]|169|1[0-5][0-9]|1[7-9][0-9]|[1-9][0-9]|[0-9]))|(172\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|1[0-5]|3[2-9]|[4-9][0-9]|[0-9])))\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "113.85.229.79"
(define-fun Witness1 () String (str.++ "1" (str.++ "1" (str.++ "3" (str.++ "." (str.++ "8" (str.++ "5" (str.++ "." (str.++ "2" (str.++ "2" (str.++ "9" (str.++ "." (str.++ "7" (str.++ "9" ""))))))))))))))
;witness2: "173.110.246.253"
(define-fun Witness2 () String (str.++ "1" (str.++ "7" (str.++ "3" (str.++ "." (str.++ "1" (str.++ "1" (str.++ "0" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "6" (str.++ "." (str.++ "2" (str.++ "5" (str.++ "3" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" ""))) (re.range "0" "1"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" ""))) (re.range "3" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "8" ""))) (re.range "0" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" ""))) (re.range "0" "1"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" ""))) (re.range "3" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "3" "6") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "2" ""))) (re.range "8" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "2" ""))) (re.range "0" "6"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "1") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1") (re.range "1" "9"))(re.union (re.++ (re.range "2" "9") (re.range "0" "9")) (re.range "0" "9"))))))))))))))(re.++ (re.range "." ".") (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "." ""))))) (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "6" ""))) (re.range "0" "7"))(re.union (str.to_re (str.++ "1" (str.++ "6" (str.++ "9" ""))))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "5") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "7" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9"))))))))) (re.++ (str.to_re (str.++ "1" (str.++ "7" (str.++ "2" (str.++ "." ""))))) (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1") (re.range "0" "5"))(re.union (re.++ (re.range "3" "3") (re.range "2" "9"))(re.union (re.++ (re.range "4" "9") (re.range "0" "9")) (re.range "0" "9"))))))))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
