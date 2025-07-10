;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^5[1-5]\d{14}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "5489109935791509"
(define-fun Witness1 () String (str.++ "5" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "3" (str.++ "5" (str.++ "7" (str.++ "9" (str.++ "1" (str.++ "5" (str.++ "0" (str.++ "9" "")))))))))))))))))
;witness2: "5168852889259953"
(define-fun Witness2 () String (str.++ "5" (str.++ "1" (str.++ "6" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "2" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "3" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "5" "5")(re.++ (re.range "1" "5")(re.++ ((_ re.loop 14 14) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
