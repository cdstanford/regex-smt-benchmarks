;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[0][2][1579]{1})(\d{6,7}$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "021168379"
(define-fun Witness1 () String (str.++ "0" (str.++ "2" (str.++ "1" (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "3" (str.++ "7" (str.++ "9" ""))))))))))
;witness2: "0218492315"
(define-fun Witness2 () String (str.++ "0" (str.++ "2" (str.++ "1" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "2" (str.++ "3" (str.++ "1" (str.++ "5" "")))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "0" (str.++ "2" ""))) (re.union (re.range "1" "1")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))))) (re.++ ((_ re.loop 6 7) (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
