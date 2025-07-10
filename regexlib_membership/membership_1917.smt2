;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{5}$|^\d{5}-\d{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "49770"
(define-fun Witness1 () String (str.++ "4" (str.++ "9" (str.++ "7" (str.++ "7" (str.++ "0" ""))))))
;witness2: "22799-9548"
(define-fun Witness2 () String (str.++ "2" (str.++ "2" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "5" (str.++ "4" (str.++ "8" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re ""))) (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
