;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =  WOW Gold
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A8 WOW Gold"
(define-fun Witness1 () String (str.++ "\u{a8}" (str.++ " " (str.++ "W" (str.++ "O" (str.++ "W" (str.++ " " (str.++ "G" (str.++ "o" (str.++ "l" (str.++ "d" "")))))))))))
;witness2: " WOW Gold\u00AE"
(define-fun Witness2 () String (str.++ " " (str.++ "W" (str.++ "O" (str.++ "W" (str.++ " " (str.++ "G" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ "\u{ae}" "")))))))))))

(assert (= regexA (str.to_re (str.++ " " (str.++ "W" (str.++ "O" (str.++ "W" (str.++ " " (str.++ "G" (str.++ "o" (str.++ "l" (str.++ "d" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
