;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = getting username from empid
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0094\u00B2\u00B5\u00A3getting username from empid"
(define-fun Witness1 () String (seq.++ "\x94" (seq.++ "\xb2" (seq.++ "\xb5" (seq.++ "\xa3" (seq.++ "g" (seq.++ "e" (seq.++ "t" (seq.++ "t" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ " " (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "r" (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ " " (seq.++ "f" (seq.++ "r" (seq.++ "o" (seq.++ "m" (seq.++ " " (seq.++ "e" (seq.++ "m" (seq.++ "p" (seq.++ "i" (seq.++ "d" ""))))))))))))))))))))))))))))))))
;witness2: "Qgetting username from empid"
(define-fun Witness2 () String (seq.++ "Q" (seq.++ "g" (seq.++ "e" (seq.++ "t" (seq.++ "t" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ " " (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "r" (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ " " (seq.++ "f" (seq.++ "r" (seq.++ "o" (seq.++ "m" (seq.++ " " (seq.++ "e" (seq.++ "m" (seq.++ "p" (seq.++ "i" (seq.++ "d" "")))))))))))))))))))))))))))))

(assert (= regexA (str.to_re (seq.++ "g" (seq.++ "e" (seq.++ "t" (seq.++ "t" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ " " (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "r" (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ " " (seq.++ "f" (seq.++ "r" (seq.++ "o" (seq.++ "m" (seq.++ " " (seq.++ "e" (seq.++ "m" (seq.++ "p" (seq.++ "i" (seq.++ "d" ""))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
