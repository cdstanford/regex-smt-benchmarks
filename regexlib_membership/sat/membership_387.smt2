;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Buy WoW Gold
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Buy WoW Gold"
(define-fun Witness1 () String (seq.++ "B" (seq.++ "u" (seq.++ "y" (seq.++ " " (seq.++ "W" (seq.++ "o" (seq.++ "W" (seq.++ " " (seq.++ "G" (seq.++ "o" (seq.++ "l" (seq.++ "d" "")))))))))))))
;witness2: "Buy WoW Gold:"
(define-fun Witness2 () String (seq.++ "B" (seq.++ "u" (seq.++ "y" (seq.++ " " (seq.++ "W" (seq.++ "o" (seq.++ "W" (seq.++ " " (seq.++ "G" (seq.++ "o" (seq.++ "l" (seq.++ "d" (seq.++ ":" ""))))))))))))))

(assert (= regexA (str.to_re (seq.++ "B" (seq.++ "u" (seq.++ "y" (seq.++ " " (seq.++ "W" (seq.++ "o" (seq.++ "W" (seq.++ " " (seq.++ "G" (seq.++ "o" (seq.++ "l" (seq.++ "d" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
