;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Removed
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Removed"
(define-fun Witness1 () String (str.++ "R" (str.++ "e" (str.++ "m" (str.++ "o" (str.++ "v" (str.++ "e" (str.++ "d" ""))))))))
;witness2: "Removed"
(define-fun Witness2 () String (str.++ "R" (str.++ "e" (str.++ "m" (str.++ "o" (str.++ "v" (str.++ "e" (str.++ "d" ""))))))))

(assert (= regexA (str.to_re (str.++ "R" (str.++ "e" (str.++ "m" (str.++ "o" (str.++ "v" (str.++ "e" (str.++ "d" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
