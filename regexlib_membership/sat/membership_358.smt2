;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-z]?\d{8}[A-z]$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "z96929778r"
(define-fun Witness1 () String (str.++ "z" (str.++ "9" (str.++ "6" (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "7" (str.++ "7" (str.++ "8" (str.++ "r" "")))))))))))
;witness2: "P67001843V"
(define-fun Witness2 () String (str.++ "P" (str.++ "6" (str.++ "7" (str.++ "0" (str.++ "0" (str.++ "1" (str.++ "8" (str.++ "4" (str.++ "3" (str.++ "V" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "A" "z"))(re.++ ((_ re.loop 8 8) (re.range "0" "9"))(re.++ (re.range "A" "z") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
