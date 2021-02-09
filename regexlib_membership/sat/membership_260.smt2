;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = runescape
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Wrunescape\u00A7\u00CF\u00E5"
(define-fun Witness1 () String (seq.++ "W" (seq.++ "r" (seq.++ "u" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ "c" (seq.++ "a" (seq.++ "p" (seq.++ "e" (seq.++ "\xa7" (seq.++ "\xcf" (seq.++ "\xe5" ""))))))))))))))
;witness2: "4\u007FIrunescape"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "\x7f" (seq.++ "I" (seq.++ "r" (seq.++ "u" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ "c" (seq.++ "a" (seq.++ "p" (seq.++ "e" "")))))))))))))

(assert (= regexA (str.to_re (seq.++ "r" (seq.++ "u" (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ "c" (seq.++ "a" (seq.++ "p" (seq.++ "e" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
