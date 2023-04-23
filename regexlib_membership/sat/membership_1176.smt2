;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\$)?(([1-9]\d{0,2}(\,\d{3})*)|([1-9]\d*)|(0))(\.\d{2})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "77,689"
(define-fun Witness1 () String (str.++ "7" (str.++ "7" (str.++ "," (str.++ "6" (str.++ "8" (str.++ "9" "")))))))
;witness2: "918,869,095"
(define-fun Witness2 () String (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "," (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "," (str.++ "0" (str.++ "9" (str.++ "5" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))(re.union (re.++ (re.range "1" "9") (re.* (re.range "0" "9"))) (re.range "0" "0")))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
