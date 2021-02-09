;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =  WOW Gold
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A8 WOW Gold"
(define-fun Witness1 () String (seq.++ "\xa8" (seq.++ " " (seq.++ "W" (seq.++ "O" (seq.++ "W" (seq.++ " " (seq.++ "G" (seq.++ "o" (seq.++ "l" (seq.++ "d" "")))))))))))
;witness2: " WOW Gold\u00AE"
(define-fun Witness2 () String (seq.++ " " (seq.++ "W" (seq.++ "O" (seq.++ "W" (seq.++ " " (seq.++ "G" (seq.++ "o" (seq.++ "l" (seq.++ "d" (seq.++ "\xae" "")))))))))))

(assert (= regexA (str.to_re (seq.++ " " (seq.++ "W" (seq.++ "O" (seq.++ "W" (seq.++ " " (seq.++ "G" (seq.++ "o" (seq.++ "l" (seq.++ "d" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
