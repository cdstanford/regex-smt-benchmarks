;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[+-]?\d*(([,.]\d{3})+)?([,.]\d+)?([eE][+-]?\d+)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-.686E+8"
(define-fun Witness1 () String (str.++ "-" (str.++ "." (str.++ "6" (str.++ "8" (str.++ "6" (str.++ "E" (str.++ "+" (str.++ "8" "")))))))))
;witness2: ",039,1E199"
(define-fun Witness2 () String (str.++ "," (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "," (str.++ "1" (str.++ "E" (str.++ "1" (str.++ "9" (str.++ "9" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.+ (re.++ (re.union (re.range "," ",") (re.range "." ".")) ((_ re.loop 3 3) (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.union (re.range "," ",") (re.range "." ".")) (re.+ (re.range "0" "9"))))(re.++ (re.opt (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.+ (re.range "0" "9"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
