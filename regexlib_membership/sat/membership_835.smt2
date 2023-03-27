;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^(2014)|^(2149))\d{11}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "214989819512626"
(define-fun Witness1 () String (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "5" (str.++ "1" (str.++ "2" (str.++ "6" (str.++ "2" (str.++ "6" ""))))))))))))))))
;witness2: "201438977999270"
(define-fun Witness2 () String (str.++ "2" (str.++ "0" (str.++ "1" (str.++ "4" (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "2" (str.++ "7" (str.++ "0" ""))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re "") (str.to_re (str.++ "2" (str.++ "0" (str.++ "1" (str.++ "4" "")))))) (re.++ (str.to_re "") (str.to_re (str.++ "2" (str.++ "1" (str.++ "4" (str.++ "9" "")))))))(re.++ ((_ re.loop 11 11) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
