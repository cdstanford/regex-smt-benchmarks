;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(1(0|7|9)2?)\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "17.98.82.211"
(define-fun Witness1 () String (str.++ "1" (str.++ "7" (str.++ "." (str.++ "9" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "2" (str.++ "." (str.++ "2" (str.++ "1" (str.++ "1" "")))))))))))))
;witness2: "102.18.222.1"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" (str.++ "2" (str.++ "." (str.++ "1" (str.++ "8" (str.++ "." (str.++ "2" (str.++ "2" (str.++ "2" (str.++ "." (str.++ "1" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "1" "1")(re.++ (re.union (re.range "0" "0")(re.union (re.range "7" "7") (re.range "9" "9"))) (re.opt (re.range "2" "2"))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (re.opt (re.range "0" "1"))(re.++ (re.opt (re.range "0" "9")) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
