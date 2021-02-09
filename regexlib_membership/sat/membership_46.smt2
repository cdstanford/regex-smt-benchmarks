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

;witness1: "\u00B2q\u00B3\u00E5xB\u009A\u00A6\'\u0086vclipvn"
(define-fun Witness1 () String (seq.++ "\xb2" (seq.++ "q" (seq.++ "\xb3" (seq.++ "\xe5" (seq.++ "x" (seq.++ "B" (seq.++ "\x9a" (seq.++ "\xa6" (seq.++ "'" (seq.++ "\x86" (seq.++ "v" (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "v" (seq.++ "n" ""))))))))))))))))))
;witness2: "clipvn\"
(define-fun Witness2 () String (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "v" (seq.++ "n" (seq.++ "\x5c" ""))))))))

(assert (= regexA (str.to_re (seq.++ "c" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "v" (seq.++ "n" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
