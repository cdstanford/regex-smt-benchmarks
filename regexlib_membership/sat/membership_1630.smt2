;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[0-9]{1,8}|(^[0-9]{1,8}\.{0,1}[0-9]{1,2}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "690"
(define-fun Witness1 () String (str.++ "6" (str.++ "9" (str.++ "0" ""))))
;witness2: "98389"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "9" ""))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re "") ((_ re.loop 1 8) (re.range "0" "9"))) (re.++ (str.to_re "")(re.++ ((_ re.loop 1 8) (re.range "0" "9"))(re.++ (re.opt (re.range "." ".")) ((_ re.loop 1 2) (re.range "0" "9")))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
