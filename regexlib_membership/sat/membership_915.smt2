;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\$([0]|([1-9]\d{1,2})|([1-9]\d{0,1},\d{3,3})|([1-9]\d{2,2},\d{3,3})|([1-9],\d{3,3},\d{3,3}))([.]\d{1,2})?$|^\(\$([0]|([1-9]\d{1,2})|([1-9]\d{0,1},\d{3,3})|([1-9]\d{2,2},\d{3,3})|([1-9],\d{3,3},\d{3,3}))([.]\d{1,2})?\)$|^(\$)?(-)?([0]|([1-9]\d{0,6}))([.]\d{1,2})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "$0.83"
(define-fun Witness1 () String (str.++ "$" (str.++ "0" (str.++ "." (str.++ "8" (str.++ "3" ""))))))
;witness2: "$8,911,999"
(define-fun Witness2 () String (str.++ "$" (str.++ "8" (str.++ "," (str.++ "9" (str.++ "1" (str.++ "1" (str.++ "," (str.++ "9" (str.++ "9" (str.++ "9" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "$" "$")(re.++ (re.union (re.range "0" "0")(re.union (re.++ (re.range "1" "9") ((_ re.loop 1 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9")))))(re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))) (re.++ (re.range "1" "9")(re.++ (re.range "," ",")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9")))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "(" (str.++ "$" "")))(re.++ (re.union (re.range "0" "0")(re.union (re.++ (re.range "1" "9") ((_ re.loop 1 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9")))))(re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))) (re.++ (re.range "1" "9")(re.++ (re.range "," ",")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9"))))(re.++ (re.range ")" ")") (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.range "0" "0") (re.++ (re.range "1" "9") ((_ re.loop 0 6) (re.range "0" "9"))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
