;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]{1}$|^[1-9]{1}[0-9]{1}$|^[1-3]{1}[0-6]{1}[0-5]{1}$|^365$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "58"
(define-fun Witness1 () String (str.++ "5" (str.++ "8" "")))
;witness2: "2"
(define-fun Witness2 () String (str.++ "2" ""))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "1" "9") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ (re.range "0" "9") (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ (re.range "1" "3")(re.++ (re.range "0" "6")(re.++ (re.range "0" "5") (str.to_re ""))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "3" (str.++ "6" (str.++ "5" "")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
