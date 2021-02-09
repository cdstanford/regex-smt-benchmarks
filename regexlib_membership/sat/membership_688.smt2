;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Source:
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Source:"
(define-fun Witness1 () String (seq.++ "S" (seq.++ "o" (seq.++ "u" (seq.++ "r" (seq.++ "c" (seq.++ "e" (seq.++ ":" ""))))))))
;witness2: "Source:"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "o" (seq.++ "u" (seq.++ "r" (seq.++ "c" (seq.++ "e" (seq.++ ":" ""))))))))

(assert (= regexA (str.to_re (seq.++ "S" (seq.++ "o" (seq.++ "u" (seq.++ "r" (seq.++ "c" (seq.++ "e" (seq.++ ":" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
