;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = clipvn
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "clipvn"
(define-fun Witness1 () String (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "v" (seq.++ "n" "")))))))
;witness2: "\u00F3\u00B9clipvn\u00E99W"
(define-fun Witness2 () String (seq.++ "\xf3" (seq.++ "\xb9" (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "v" (seq.++ "n" (seq.++ "\xe9" (seq.++ "9" (seq.++ "W" ""))))))))))))

(assert (= regexA (str.to_re (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "v" (seq.++ "n" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
