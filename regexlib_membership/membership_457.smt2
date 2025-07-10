;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]\d{2}(\.\d){0,1}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "S98"
(define-fun Witness1 () String (str.++ "S" (str.++ "9" (str.++ "8" ""))))
;witness2: "L97.9"
(define-fun Witness2 () String (str.++ "L" (str.++ "9" (str.++ "7" (str.++ "." (str.++ "9" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "Z")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "." ".") (re.range "0" "9"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
