;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = getting username from empid
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0094\u00B2\u00B5\u00A3getting username from empid"
(define-fun Witness1 () String (str.++ "\u{94}" (str.++ "\u{b2}" (str.++ "\u{b5}" (str.++ "\u{a3}" (str.++ "g" (str.++ "e" (str.++ "t" (str.++ "t" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "r" (str.++ "o" (str.++ "m" (str.++ " " (str.++ "e" (str.++ "m" (str.++ "p" (str.++ "i" (str.++ "d" ""))))))))))))))))))))))))))))))))
;witness2: "Qgetting username from empid"
(define-fun Witness2 () String (str.++ "Q" (str.++ "g" (str.++ "e" (str.++ "t" (str.++ "t" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "r" (str.++ "o" (str.++ "m" (str.++ " " (str.++ "e" (str.++ "m" (str.++ "p" (str.++ "i" (str.++ "d" "")))))))))))))))))))))))))))))

(assert (= regexA (str.to_re (str.++ "g" (str.++ "e" (str.++ "t" (str.++ "t" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "r" (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ " " (str.++ "f" (str.++ "r" (str.++ "o" (str.++ "m" (str.++ " " (str.++ "e" (str.++ "m" (str.++ "p" (str.++ "i" (str.++ "d" ""))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
