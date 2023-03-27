;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Buy WoW Gold
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Buy WoW Gold"
(define-fun Witness1 () String (str.++ "B" (str.++ "u" (str.++ "y" (str.++ " " (str.++ "W" (str.++ "o" (str.++ "W" (str.++ " " (str.++ "G" (str.++ "o" (str.++ "l" (str.++ "d" "")))))))))))))
;witness2: "Buy WoW Gold:"
(define-fun Witness2 () String (str.++ "B" (str.++ "u" (str.++ "y" (str.++ " " (str.++ "W" (str.++ "o" (str.++ "W" (str.++ " " (str.++ "G" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ ":" ""))))))))))))))

(assert (= regexA (str.to_re (str.++ "B" (str.++ "u" (str.++ "y" (str.++ " " (str.++ "W" (str.++ "o" (str.++ "W" (str.++ " " (str.++ "G" (str.++ "o" (str.++ "l" (str.++ "d" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
