;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = sample
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "sample\u00A4h"
(define-fun Witness1 () String (str.++ "s" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "\u{a4}" (str.++ "h" "")))))))))
;witness2: "sample\u00D1"
(define-fun Witness2 () String (str.++ "s" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" (str.++ "\u{d1}" ""))))))))

(assert (= regexA (str.to_re (str.++ "s" (str.++ "a" (str.++ "m" (str.++ "p" (str.++ "l" (str.++ "e" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
