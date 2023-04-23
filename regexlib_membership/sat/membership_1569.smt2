;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = regex
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "regexS"
(define-fun Witness1 () String (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "e" (str.++ "x" (str.++ "S" "")))))))
;witness2: "iregex"
(define-fun Witness2 () String (str.++ "i" (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "e" (str.++ "x" "")))))))

(assert (= regexA (str.to_re (str.++ "r" (str.++ "e" (str.++ "g" (str.++ "e" (str.++ "x" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
