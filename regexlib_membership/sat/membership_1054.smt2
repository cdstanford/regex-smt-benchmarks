;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^04[0-9]{8}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0459890391\u0080"
(define-fun Witness1 () String (str.++ "0" (str.++ "4" (str.++ "5" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "1" (str.++ "\u{80}" ""))))))))))))
;witness2: "0499983374"
(define-fun Witness2 () String (str.++ "0" (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "3" (str.++ "7" (str.++ "4" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "0" (str.++ "4" ""))) ((_ re.loop 8 8) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
