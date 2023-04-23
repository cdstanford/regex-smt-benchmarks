;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Source:
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Source:"
(define-fun Witness1 () String (str.++ "S" (str.++ "o" (str.++ "u" (str.++ "r" (str.++ "c" (str.++ "e" (str.++ ":" ""))))))))
;witness2: "Source:"
(define-fun Witness2 () String (str.++ "S" (str.++ "o" (str.++ "u" (str.++ "r" (str.++ "c" (str.++ "e" (str.++ ":" ""))))))))

(assert (= regexA (str.to_re (str.++ "S" (str.++ "o" (str.++ "u" (str.++ "r" (str.++ "c" (str.++ "e" (str.++ ":" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
