;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-]?\d{1,10}\.?([0-9][0-9])?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-889."
(define-fun Witness1 () String (str.++ "-" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "." ""))))))
;witness2: "1.83"
(define-fun Witness2 () String (str.++ "1" (str.++ "." (str.++ "8" (str.++ "3" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 1 10) (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.opt (re.++ (re.range "0" "9") (re.range "0" "9"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
