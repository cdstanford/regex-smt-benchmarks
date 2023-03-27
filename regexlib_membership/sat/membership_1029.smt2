;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(EE|EL|DE|PT){0,1}[0-9]{9}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "EE607366299"
(define-fun Witness1 () String (str.++ "E" (str.++ "E" (str.++ "6" (str.++ "0" (str.++ "7" (str.++ "3" (str.++ "6" (str.++ "6" (str.++ "2" (str.++ "9" (str.++ "9" ""))))))))))))
;witness2: "EL906983884"
(define-fun Witness2 () String (str.++ "E" (str.++ "L" (str.++ "9" (str.++ "0" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "4" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (str.++ "E" (str.++ "E" "")))(re.union (str.to_re (str.++ "E" (str.++ "L" "")))(re.union (str.to_re (str.++ "D" (str.++ "E" ""))) (str.to_re (str.++ "P" (str.++ "T" "")))))))(re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
