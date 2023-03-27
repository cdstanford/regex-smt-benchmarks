;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1][0-9]|[0-9])[1-9]{2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1734"
(define-fun Witness1 () String (str.++ "1" (str.++ "7" (str.++ "3" (str.++ "4" "")))))
;witness2: "1928"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.range "0" "9"))(re.++ ((_ re.loop 2 2) (re.range "1" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
