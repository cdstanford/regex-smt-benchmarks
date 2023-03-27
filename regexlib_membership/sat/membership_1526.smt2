;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d+(?:\.\d{0,2})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "959.8"
(define-fun Witness1 () String (str.++ "9" (str.++ "5" (str.++ "9" (str.++ "." (str.++ "8" ""))))))
;witness2: "3.98"
(define-fun Witness2 () String (str.++ "3" (str.++ "." (str.++ "9" (str.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
