;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]*(\.)?[0-9]+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".4"
(define-fun Witness1 () String (str.++ "." (str.++ "4" "")))
;witness2: ".577"
(define-fun Witness2 () String (str.++ "." (str.++ "5" (str.++ "7" (str.++ "7" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
