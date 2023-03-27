;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = wow gold 
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F6wow gold @"
(define-fun Witness1 () String (str.++ "\u{f6}" (str.++ "w" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "g" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ " " (str.++ "@" ""))))))))))))
;witness2: "wow gold "
(define-fun Witness2 () String (str.++ "w" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "g" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ " " ""))))))))))

(assert (= regexA (str.to_re (str.++ "w" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "g" (str.++ "o" (str.++ "l" (str.++ "d" (str.++ " " ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
