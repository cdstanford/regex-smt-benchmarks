;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Percentage allowing upto 4 places of decimal
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Percentage allowing upto 4 places of decimal"
(define-fun Witness1 () String (seq.++ "P" (seq.++ "e" (seq.++ "r" (seq.++ "c" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ "a" (seq.++ "g" (seq.++ "e" (seq.++ " " (seq.++ "a" (seq.++ "l" (seq.++ "l" (seq.++ "o" (seq.++ "w" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ " " (seq.++ "u" (seq.++ "p" (seq.++ "t" (seq.++ "o" (seq.++ " " (seq.++ "4" (seq.++ " " (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "c" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "d" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "m" (seq.++ "a" (seq.++ "l" "")))))))))))))))))))))))))))))))))))))))))))))
;witness2: "Percentage allowing upto 4 places of decimal\u009F&:\u00DA"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "e" (seq.++ "r" (seq.++ "c" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ "a" (seq.++ "g" (seq.++ "e" (seq.++ " " (seq.++ "a" (seq.++ "l" (seq.++ "l" (seq.++ "o" (seq.++ "w" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ " " (seq.++ "u" (seq.++ "p" (seq.++ "t" (seq.++ "o" (seq.++ " " (seq.++ "4" (seq.++ " " (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "c" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "d" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "m" (seq.++ "a" (seq.++ "l" (seq.++ "\x9f" (seq.++ "&" (seq.++ ":" (seq.++ "\xda" "")))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (str.to_re (seq.++ "P" (seq.++ "e" (seq.++ "r" (seq.++ "c" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ "a" (seq.++ "g" (seq.++ "e" (seq.++ " " (seq.++ "a" (seq.++ "l" (seq.++ "l" (seq.++ "o" (seq.++ "w" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ " " (seq.++ "u" (seq.++ "p" (seq.++ "t" (seq.++ "o" (seq.++ " " (seq.++ "4" (seq.++ " " (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "c" (seq.++ "e" (seq.++ "s" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "d" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "m" (seq.++ "a" (seq.++ "l" "")))))))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
