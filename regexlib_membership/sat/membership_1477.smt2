;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\-)?1000([.][0]{1,3})?$|^(\-)?\d{1,3}$|^(\-)?\d{1,3}([.]\d{1,3})$|^(\-)?([.]\d{1,3})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9"
(define-fun Witness1 () String (str.++ "9" ""))
;witness2: "1000.00"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" (str.++ "0" (str.++ "0" (str.++ "." (str.++ "0" (str.++ "0" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "0" (str.++ "0" "")))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "0")))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9"))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
