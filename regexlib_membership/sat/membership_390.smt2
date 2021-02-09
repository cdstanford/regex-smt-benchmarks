;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = wow gold 
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F6wow gold @"
(define-fun Witness1 () String (seq.++ "\xf6" (seq.++ "w" (seq.++ "o" (seq.++ "w" (seq.++ " " (seq.++ "g" (seq.++ "o" (seq.++ "l" (seq.++ "d" (seq.++ " " (seq.++ "@" ""))))))))))))
;witness2: "wow gold "
(define-fun Witness2 () String (seq.++ "w" (seq.++ "o" (seq.++ "w" (seq.++ " " (seq.++ "g" (seq.++ "o" (seq.++ "l" (seq.++ "d" (seq.++ " " ""))))))))))

(assert (= regexA (str.to_re (seq.++ "w" (seq.++ "o" (seq.++ "w" (seq.++ " " (seq.++ "g" (seq.++ "o" (seq.++ "l" (seq.++ "d" (seq.++ " " ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
