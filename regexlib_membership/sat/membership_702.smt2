;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = how to block pdf spam
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "how to block pdf spam\u00C2."
(define-fun Witness1 () String (str.++ "h" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "t" (str.++ "o" (str.++ " " (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ " " (str.++ "p" (str.++ "d" (str.++ "f" (str.++ " " (str.++ "s" (str.++ "p" (str.++ "a" (str.++ "m" (str.++ "\u{c2}" (str.++ "." ""))))))))))))))))))))))))
;witness2: "\u00DBhow to block pdf spam\u00CC\xB"
(define-fun Witness2 () String (str.++ "\u{db}" (str.++ "h" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "t" (str.++ "o" (str.++ " " (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ " " (str.++ "p" (str.++ "d" (str.++ "f" (str.++ " " (str.++ "s" (str.++ "p" (str.++ "a" (str.++ "m" (str.++ "\u{cc}" (str.++ "\u{0b}" "")))))))))))))))))))))))))

(assert (= regexA (str.to_re (str.++ "h" (str.++ "o" (str.++ "w" (str.++ " " (str.++ "t" (str.++ "o" (str.++ " " (str.++ "b" (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "k" (str.++ " " (str.++ "p" (str.++ "d" (str.++ "f" (str.++ " " (str.++ "s" (str.++ "p" (str.++ "a" (str.++ "m" ""))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
