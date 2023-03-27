;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Percentage allowing upto 4 places of decimal
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Percentage allowing upto 4 places of decimal"
(define-fun Witness1 () String (str.++ "P" (str.++ "e" (str.++ "r" (str.++ "c" (str.++ "e" (str.++ "n" (str.++ "t" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "u" (str.++ "p" (str.++ "t" (str.++ "o" (str.++ " " (str.++ "4" (str.++ " " (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "c" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "d" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "m" (str.++ "a" (str.++ "l" "")))))))))))))))))))))))))))))))))))))))))))))
;witness2: "Percentage allowing upto 4 places of decimal\u009F&:\u00DA"
(define-fun Witness2 () String (str.++ "P" (str.++ "e" (str.++ "r" (str.++ "c" (str.++ "e" (str.++ "n" (str.++ "t" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "u" (str.++ "p" (str.++ "t" (str.++ "o" (str.++ " " (str.++ "4" (str.++ " " (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "c" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "d" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "m" (str.++ "a" (str.++ "l" (str.++ "\u{9f}" (str.++ "&" (str.++ ":" (str.++ "\u{da}" "")))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (str.to_re (str.++ "P" (str.++ "e" (str.++ "r" (str.++ "c" (str.++ "e" (str.++ "n" (str.++ "t" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ " " (str.++ "a" (str.++ "l" (str.++ "l" (str.++ "o" (str.++ "w" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ " " (str.++ "u" (str.++ "p" (str.++ "t" (str.++ "o" (str.++ " " (str.++ "4" (str.++ " " (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "c" (str.++ "e" (str.++ "s" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "d" (str.++ "e" (str.++ "c" (str.++ "i" (str.++ "m" (str.++ "a" (str.++ "l" "")))))))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
