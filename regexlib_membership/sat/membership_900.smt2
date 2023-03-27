;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^-?([1]?[1-7][1-9]|[1]?[1-8][0]|[1-9]?[0-9])\.{1}\d{1,6}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-180.95"
(define-fun Witness1 () String (str.++ "-" (str.++ "1" (str.++ "8" (str.++ "0" (str.++ "." (str.++ "9" (str.++ "5" ""))))))))
;witness2: "-80.0"
(define-fun Witness2 () String (str.++ "-" (str.++ "8" (str.++ "0" (str.++ "." (str.++ "0" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.++ (re.opt (re.range "1" "1"))(re.++ (re.range "1" "7") (re.range "1" "9")))(re.union (re.++ (re.opt (re.range "1" "1"))(re.++ (re.range "1" "8") (re.range "0" "0"))) (re.++ (re.opt (re.range "1" "9")) (re.range "0" "9"))))(re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
