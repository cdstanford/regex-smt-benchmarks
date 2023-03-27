;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0\.|([1-9]([0-9]+)?)\.){3}(0|([1-9]([0-9]+)?)){1}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0.91.4.0"
(define-fun Witness1 () String (str.++ "0" (str.++ "." (str.++ "9" (str.++ "1" (str.++ "." (str.++ "4" (str.++ "." (str.++ "0" "")))))))))
;witness2: "0.0.0.2815"
(define-fun Witness2 () String (str.++ "0" (str.++ "." (str.++ "0" (str.++ "." (str.++ "0" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "1" (str.++ "5" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.union (str.to_re (str.++ "0" (str.++ "." ""))) (re.++ (re.++ (re.range "1" "9") (re.opt (re.+ (re.range "0" "9")))) (re.range "." "."))))(re.++ (re.union (re.range "0" "0") (re.++ (re.range "1" "9") (re.opt (re.+ (re.range "0" "9"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
