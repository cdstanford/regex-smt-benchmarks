;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Write modules for Drupal
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "d|Write modules for Drupal\u00DC"
(define-fun Witness1 () String (seq.++ "d" (seq.++ "|" (seq.++ "W" (seq.++ "r" (seq.++ "i" (seq.++ "t" (seq.++ "e" (seq.++ " " (seq.++ "m" (seq.++ "o" (seq.++ "d" (seq.++ "u" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "f" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "D" (seq.++ "r" (seq.++ "u" (seq.++ "p" (seq.++ "a" (seq.++ "l" (seq.++ "\xdc" ""))))))))))))))))))))))))))))
;witness2: "\"\u00ECWrite modules for Drupal\u00ABnr"
(define-fun Witness2 () String (seq.++ "\x22" (seq.++ "\xec" (seq.++ "W" (seq.++ "r" (seq.++ "i" (seq.++ "t" (seq.++ "e" (seq.++ " " (seq.++ "m" (seq.++ "o" (seq.++ "d" (seq.++ "u" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "f" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "D" (seq.++ "r" (seq.++ "u" (seq.++ "p" (seq.++ "a" (seq.++ "l" (seq.++ "\xab" (seq.++ "n" (seq.++ "r" ""))))))))))))))))))))))))))))))

(assert (= regexA (str.to_re (seq.++ "W" (seq.++ "r" (seq.++ "i" (seq.++ "t" (seq.++ "e" (seq.++ " " (seq.++ "m" (seq.++ "o" (seq.++ "d" (seq.++ "u" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "f" (seq.++ "o" (seq.++ "r" (seq.++ " " (seq.++ "D" (seq.++ "r" (seq.++ "u" (seq.++ "p" (seq.++ "a" (seq.++ "l" "")))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
