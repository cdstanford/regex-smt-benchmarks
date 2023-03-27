;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^([1-3]{1}[0-9]{0,}(\.[0-9]{1})?|0(\.[0-9]{1})?|[4]{1}[0-9]{0,}(\.[0]{1})?|5(\.[5]{1}))$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "10.9"
(define-fun Witness1 () String (str.++ "1" (str.++ "0" (str.++ "." (str.++ "9" "")))))
;witness2: "4919"
(define-fun Witness2 () String (str.++ "4" (str.++ "9" (str.++ "1" (str.++ "9" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "3")(re.++ (re.* (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") (re.range "0" "9")))))(re.union (re.++ (re.range "0" "0") (re.opt (re.++ (re.range "." ".") (re.range "0" "9"))))(re.union (re.++ (re.range "4" "4")(re.++ (re.* (re.range "0" "9")) (re.opt (str.to_re (str.++ "." (str.++ "0" "")))))) (re.++ (re.range "5" "5") (str.to_re (str.++ "." (str.++ "5" ""))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
