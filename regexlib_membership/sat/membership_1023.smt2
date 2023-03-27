;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(CZ){0,1}[0-9]{8,10}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "52769809"
(define-fun Witness1 () String (str.++ "5" (str.++ "2" (str.++ "7" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "9" "")))))))))
;witness2: "CZ868087089"
(define-fun Witness2 () String (str.++ "C" (str.++ "Z" (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "7" (str.++ "0" (str.++ "8" (str.++ "9" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "C" (str.++ "Z" ""))))(re.++ ((_ re.loop 8 10) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
