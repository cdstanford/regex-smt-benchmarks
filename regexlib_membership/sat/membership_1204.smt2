;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "81899.06"
(define-fun Witness1 () String (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "0" (str.++ "6" "")))))))))
;witness2: "2"
(define-fun Witness2 () String (str.++ "2" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "$" "$") (str.to_re ""))(re.++ (re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9")))))) (re.++ (re.range "1" "9") (re.* (re.range "0" "9"))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
