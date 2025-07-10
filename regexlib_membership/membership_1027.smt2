;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(PL|SK){0,1}[0-9]{10}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "SK8061988199"
(define-fun Witness1 () String (str.++ "S" (str.++ "K" (str.++ "8" (str.++ "0" (str.++ "6" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "9" "")))))))))))))
;witness2: "SK9098599109"
(define-fun Witness2 () String (str.++ "S" (str.++ "K" (str.++ "9" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "1" (str.++ "0" (str.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (str.++ "P" (str.++ "L" ""))) (str.to_re (str.++ "S" (str.++ "K" "")))))(re.++ ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
