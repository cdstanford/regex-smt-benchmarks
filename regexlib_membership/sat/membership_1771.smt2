;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{0,2})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "$98."
(define-fun Witness1 () String (str.++ "$" (str.++ "9" (str.++ "8" (str.++ "." "")))))
;witness2: "8,223,787,777"
(define-fun Witness2 () String (str.++ "8" (str.++ "," (str.++ "2" (str.++ "2" (str.++ "3" (str.++ "," (str.++ "7" (str.++ "8" (str.++ "7" (str.++ "," (str.++ "7" (str.++ "7" (str.++ "7" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))) (re.+ (re.range "0" "9")))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
