;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = how to block pdf spam
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "how to block pdf spam\u00C2."
(define-fun Witness1 () String (seq.++ "h" (seq.++ "o" (seq.++ "w" (seq.++ " " (seq.++ "t" (seq.++ "o" (seq.++ " " (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ " " (seq.++ "p" (seq.++ "d" (seq.++ "f" (seq.++ " " (seq.++ "s" (seq.++ "p" (seq.++ "a" (seq.++ "m" (seq.++ "\xc2" (seq.++ "." ""))))))))))))))))))))))))
;witness2: "\u00DBhow to block pdf spam\u00CC\xB"
(define-fun Witness2 () String (seq.++ "\xdb" (seq.++ "h" (seq.++ "o" (seq.++ "w" (seq.++ " " (seq.++ "t" (seq.++ "o" (seq.++ " " (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ " " (seq.++ "p" (seq.++ "d" (seq.++ "f" (seq.++ " " (seq.++ "s" (seq.++ "p" (seq.++ "a" (seq.++ "m" (seq.++ "\xcc" (seq.++ "\x0b" "")))))))))))))))))))))))))

(assert (= regexA (str.to_re (seq.++ "h" (seq.++ "o" (seq.++ "w" (seq.++ " " (seq.++ "t" (seq.++ "o" (seq.++ " " (seq.++ "b" (seq.++ "l" (seq.++ "o" (seq.++ "c" (seq.++ "k" (seq.++ " " (seq.++ "p" (seq.++ "d" (seq.++ "f" (seq.++ " " (seq.++ "s" (seq.++ "p" (seq.++ "a" (seq.++ "m" ""))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
