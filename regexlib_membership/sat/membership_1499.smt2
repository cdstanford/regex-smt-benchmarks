;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([+]39)?((38[{8,9}|0])|(34[{7-9}|0])|(36[6|8|0])|(33[{3-9}|0])|(32[{8,9}]))([\d]{7})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+3936|7692991"
(define-fun Witness1 () String (str.++ "+" (str.++ "3" (str.++ "9" (str.++ "3" (str.++ "6" (str.++ "|" (str.++ "7" (str.++ "6" (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "1" ""))))))))))))))
;witness2: "+393395895778"
(define-fun Witness2 () String (str.++ "+" (str.++ "3" (str.++ "9" (str.++ "3" (str.++ "3" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "7" (str.++ "7" (str.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "+" (str.++ "3" (str.++ "9" "")))))(re.++ (re.union (re.++ (str.to_re (str.++ "3" (str.++ "8" ""))) (re.union (re.range "," ",")(re.union (re.range "0" "0")(re.union (re.range "8" "9") (re.range "{" "}")))))(re.union (re.++ (str.to_re (str.++ "3" (str.++ "4" ""))) (re.union (re.range "0" "0")(re.union (re.range "7" "9") (re.range "{" "}"))))(re.union (re.++ (str.to_re (str.++ "3" (str.++ "6" ""))) (re.union (re.range "0" "0")(re.union (re.range "6" "6")(re.union (re.range "8" "8") (re.range "|" "|")))))(re.union (re.++ (str.to_re (str.++ "3" (str.++ "3" ""))) (re.union (re.range "0" "0")(re.union (re.range "3" "9") (re.range "{" "}")))) (re.++ (str.to_re (str.++ "3" (str.++ "2" ""))) (re.union (re.range "," ",")(re.union (re.range "8" "9")(re.union (re.range "{" "{") (re.range "}" "}")))))))))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
