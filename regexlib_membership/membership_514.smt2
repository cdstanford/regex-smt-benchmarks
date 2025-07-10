;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Write modules for Drupal
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "d|Write modules for Drupal\u00DC"
(define-fun Witness1 () String (str.++ "d" (str.++ "|" (str.++ "W" (str.++ "r" (str.++ "i" (str.++ "t" (str.++ "e" (str.++ " " (str.++ "m" (str.++ "o" (str.++ "d" (str.++ "u" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "D" (str.++ "r" (str.++ "u" (str.++ "p" (str.++ "a" (str.++ "l" (str.++ "\u{dc}" ""))))))))))))))))))))))))))))
;witness2: "\"\u00ECWrite modules for Drupal\u00ABnr"
(define-fun Witness2 () String (str.++ "\u{22}" (str.++ "\u{ec}" (str.++ "W" (str.++ "r" (str.++ "i" (str.++ "t" (str.++ "e" (str.++ " " (str.++ "m" (str.++ "o" (str.++ "d" (str.++ "u" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "D" (str.++ "r" (str.++ "u" (str.++ "p" (str.++ "a" (str.++ "l" (str.++ "\u{ab}" (str.++ "n" (str.++ "r" ""))))))))))))))))))))))))))))))

(assert (= regexA (str.to_re (str.++ "W" (str.++ "r" (str.++ "i" (str.++ "t" (str.++ "e" (str.++ " " (str.++ "m" (str.++ "o" (str.++ "d" (str.++ "u" (str.++ "l" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "f" (str.++ "o" (str.++ "r" (str.++ " " (str.++ "D" (str.++ "r" (str.++ "u" (str.++ "p" (str.++ "a" (str.++ "l" "")))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
