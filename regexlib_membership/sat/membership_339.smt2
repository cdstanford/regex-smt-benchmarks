;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{5}-\d{2}-\d{7})*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "96239-99-953989448788-98-7928876"
(define-fun Witness1 () String (str.++ "9" (str.++ "6" (str.++ "2" (str.++ "3" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "5" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "4" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "7" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "6" "")))))))))))))))))))))))))))))))))
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 7 7) (re.range "0" "9"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
