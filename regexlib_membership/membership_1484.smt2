;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\$)?((\d+)|(\d{1,3})(\,\d{3})*)(\.\d{2,})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "8"
(define-fun Witness1 () String (str.++ "8" ""))
;witness2: "$79,090,818,718,879"
(define-fun Witness2 () String (str.++ "$" (str.++ "7" (str.++ "9" (str.++ "," (str.++ "0" (str.++ "9" (str.++ "0" (str.++ "," (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "," (str.++ "7" (str.++ "1" (str.++ "8" (str.++ "," (str.++ "8" (str.++ "7" (str.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.+ (re.range "0" "9")) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))(re.++ (re.opt (re.++ (re.range "." ".") (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.* (re.range "0" "9"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
