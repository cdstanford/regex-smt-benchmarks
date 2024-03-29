;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-2]{0,1})([0-3]{1})(\.[0-9]{1,2})?$|^([0-1]{0,1})([0-9]{1})(\.[0-9]{1,2})?$|^-?(24)(\.[0]{1,2})?$|^([0-9]{1})(\.[0-9]{1,2})?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9"
(define-fun Witness1 () String (str.++ "9" ""))
;witness2: "16.07"
(define-fun Witness2 () String (str.++ "1" (str.++ "6" (str.++ "." (str.++ "0" (str.++ "7" ""))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "2"))(re.++ (re.range "0" "3")(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9")))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9")))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (str.to_re (str.++ "2" (str.++ "4" "")))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "0")))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9")))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
