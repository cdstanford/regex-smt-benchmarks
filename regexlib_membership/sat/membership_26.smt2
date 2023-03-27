;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]{1}$|^[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}$|^9999$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9999"
(define-fun Witness1 () String (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" "")))))
;witness2: "9999"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" "")))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "1" "9") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" ""))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
