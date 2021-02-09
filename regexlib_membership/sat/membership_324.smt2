;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = test
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "etest?"
(define-fun Witness1 () String (seq.++ "e" (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "t" (seq.++ "?" "")))))))
;witness2: "$test"
(define-fun Witness2 () String (seq.++ "$" (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "t" ""))))))

(assert (= regexA (str.to_re (seq.++ "t" (seq.++ "e" (seq.++ "s" (seq.++ "t" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
