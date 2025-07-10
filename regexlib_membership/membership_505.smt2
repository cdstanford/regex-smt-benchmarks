;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{1,8}|(\d{0,8}\.{1}\d{1,2}){1})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "89863.1"
(define-fun Witness1 () String (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "3" (str.++ "." (str.++ "1" ""))))))))
;witness2: "89"
(define-fun Witness2 () String (str.++ "8" (str.++ "9" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 1 8) (re.range "0" "9")) (re.++ ((_ re.loop 0 8) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 2) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
