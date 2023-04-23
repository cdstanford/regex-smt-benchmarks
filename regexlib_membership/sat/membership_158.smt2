;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^-?((([1]?[0-7][0-9]|[1-9]?[0-9])\.{1}\d{1,6}$)|[1]?[1-8][0]\.{1}0{1,6}$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-180.000"
(define-fun Witness1 () String (str.++ "-" (str.++ "1" (str.++ "8" (str.++ "0" (str.++ "." (str.++ "0" (str.++ "0" (str.++ "0" "")))))))))
;witness2: "69.8"
(define-fun Witness2 () String (str.++ "6" (str.++ "9" (str.++ "." (str.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-")) (re.union (re.++ (re.union (re.++ (re.opt (re.range "1" "1"))(re.++ (re.range "0" "7") (re.range "0" "9"))) (re.++ (re.opt (re.range "1" "9")) (re.range "0" "9")))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 6) (re.range "0" "9")) (str.to_re "")))) (re.++ (re.opt (re.range "1" "1"))(re.++ (re.range "1" "8")(re.++ (str.to_re (str.++ "0" (str.++ "." "")))(re.++ ((_ re.loop 1 6) (re.range "0" "0")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
