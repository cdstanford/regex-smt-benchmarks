;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([+]\d{2}[ ][1-9]\d{0,2}[ ])|([0]\d{1,3}[-]))((\d{2}([ ]\d{2}){2})|(\d{3}([ ]\d{3})*([ ]\d{2})+))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+69 1 098 990 23"
(define-fun Witness1 () String (str.++ "+" (str.++ "6" (str.++ "9" (str.++ " " (str.++ "1" (str.++ " " (str.++ "0" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "0" (str.++ " " (str.++ "2" (str.++ "3" "")))))))))))))))))
;witness2: "0049-588 997 83"
(define-fun Witness2 () String (str.++ "0" (str.++ "0" (str.++ "4" (str.++ "9" (str.++ "-" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "7" (str.++ " " (str.++ "8" (str.++ "3" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "+" "+")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (re.range " " " ")))))) (re.++ (re.range "0" "0")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "-" "-"))))(re.++ (re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 2 2) (re.++ (re.range " " " ") ((_ re.loop 2 2) (re.range "0" "9"))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.++ (re.range " " " ") ((_ re.loop 3 3) (re.range "0" "9")))) (re.+ (re.++ (re.range " " " ") ((_ re.loop 2 2) (re.range "0" "9"))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
