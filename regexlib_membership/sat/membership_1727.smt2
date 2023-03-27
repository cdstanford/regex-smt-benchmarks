;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([1][12]|[0]?[1-9])[\/-]([3][01]|[12]\d|[0]?[1-9])[\/-](\d{4}|\d{2})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "07-08/8109"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ "-" (str.++ "0" (str.++ "8" (str.++ "/" (str.++ "8" (str.++ "1" (str.++ "0" (str.++ "9" "")))))))))))
;witness2: "03/9-1599"
(define-fun Witness2 () String (str.++ "0" (str.++ "3" (str.++ "/" (str.++ "9" (str.++ "-" (str.++ "1" (str.++ "5" (str.++ "9" (str.++ "9" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "1" "1") (re.range "1" "2")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union (re.++ (re.range "3" "3") (re.range "0" "1"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))))(re.++ (re.union (re.range "-" "-") (re.range "/" "/"))(re.++ (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
