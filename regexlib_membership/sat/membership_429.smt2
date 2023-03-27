;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{1,3},)?(\d{3},)+\d{3}(\.\d*)?$|^(\d*)(\.\d*)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".29"
(define-fun Witness1 () String (str.++ "." (str.++ "2" (str.++ "9" ""))))
;witness2: "5,249,554,627,388,499.884"
(define-fun Witness2 () String (str.++ "5" (str.++ "," (str.++ "2" (str.++ "4" (str.++ "9" (str.++ "," (str.++ "5" (str.++ "5" (str.++ "4" (str.++ "," (str.++ "6" (str.++ "2" (str.++ "7" (str.++ "," (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "," (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "8" (str.++ "8" (str.++ "4" ""))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "," ",")))(re.++ (re.+ (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "," ",")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "." ".") (re.* (re.range "0" "9")))) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "." ".") (re.* (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
