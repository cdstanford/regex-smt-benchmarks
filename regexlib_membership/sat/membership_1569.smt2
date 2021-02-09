;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = regex
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "regexS"
(define-fun Witness1 () String (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "e" (seq.++ "x" (seq.++ "S" "")))))))
;witness2: "iregex"
(define-fun Witness2 () String (seq.++ "i" (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "e" (seq.++ "x" "")))))))

(assert (= regexA (str.to_re (seq.++ "r" (seq.++ "e" (seq.++ "g" (seq.++ "e" (seq.++ "x" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
