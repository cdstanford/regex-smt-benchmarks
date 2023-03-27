;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(BE){0,1}[0]{0,1}[0-9]{9}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "BE832295091"
(define-fun Witness1 () String (str.++ "B" (str.++ "E" (str.++ "8" (str.++ "3" (str.++ "2" (str.++ "2" (str.++ "9" (str.++ "5" (str.++ "0" (str.++ "9" (str.++ "1" ""))))))))))))
;witness2: "286193060"
(define-fun Witness2 () String (str.++ "2" (str.++ "8" (str.++ "6" (str.++ "1" (str.++ "9" (str.++ "3" (str.++ "0" (str.++ "6" (str.++ "0" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "B" (str.++ "E" ""))))(re.++ (re.opt (re.range "0" "0"))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
