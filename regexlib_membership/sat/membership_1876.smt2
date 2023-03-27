;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "809)-Xr3E9X1"
(define-fun Witness1 () String (str.++ "8" (str.++ "0" (str.++ "9" (str.++ ")" (str.++ "-" (str.++ "X" (str.++ "r" (str.++ "3" (str.++ "E" (str.++ "9" (str.++ "X" (str.++ "1" "")))))))))))))
;witness2: "8(689)A13tz95"
(define-fun Witness2 () String (str.++ "8" (str.++ "(" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ ")" (str.++ "A" (str.++ "1" (str.++ "3" (str.++ "t" (str.++ "z" (str.++ "9" (str.++ "5" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.range "0" "9") (re.opt (re.union (re.range " " " ") (re.range "-" "-")))))(re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.range ")" ")")))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9")))) ((_ re.loop 7 7) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
