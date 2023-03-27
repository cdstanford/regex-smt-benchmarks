;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(IT|LV){0,1}[0-9]{11}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "27884833615"
(define-fun Witness1 () String (str.++ "2" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "3" (str.++ "3" (str.++ "6" (str.++ "1" (str.++ "5" ""))))))))))))
;witness2: "71679972968"
(define-fun Witness2 () String (str.++ "7" (str.++ "1" (str.++ "6" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "2" (str.++ "9" (str.++ "6" (str.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (str.++ "I" (str.++ "T" ""))) (str.to_re (str.++ "L" (str.++ "V" "")))))(re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
