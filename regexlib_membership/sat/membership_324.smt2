;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = test
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "etest?"
(define-fun Witness1 () String (str.++ "e" (str.++ "t" (str.++ "e" (str.++ "s" (str.++ "t" (str.++ "?" "")))))))
;witness2: "$test"
(define-fun Witness2 () String (str.++ "$" (str.++ "t" (str.++ "e" (str.++ "s" (str.++ "t" ""))))))

(assert (= regexA (str.to_re (str.++ "t" (str.++ "e" (str.++ "s" (str.++ "t" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
