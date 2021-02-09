;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = World of Warcraft Powerleveling
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "World of Warcraft Powerleveling\x13\u00CA"
(define-fun Witness1 () String (seq.++ "W" (seq.++ "o" (seq.++ "r" (seq.++ "l" (seq.++ "d" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "W" (seq.++ "a" (seq.++ "r" (seq.++ "c" (seq.++ "r" (seq.++ "a" (seq.++ "f" (seq.++ "t" (seq.++ " " (seq.++ "P" (seq.++ "o" (seq.++ "w" (seq.++ "e" (seq.++ "r" (seq.++ "l" (seq.++ "e" (seq.++ "v" (seq.++ "e" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ "\x13" (seq.++ "\xca" ""))))))))))))))))))))))))))))))))))
;witness2: "\x5\u00885World of Warcraft Powerleveling"
(define-fun Witness2 () String (seq.++ "\x05" (seq.++ "\x88" (seq.++ "5" (seq.++ "W" (seq.++ "o" (seq.++ "r" (seq.++ "l" (seq.++ "d" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "W" (seq.++ "a" (seq.++ "r" (seq.++ "c" (seq.++ "r" (seq.++ "a" (seq.++ "f" (seq.++ "t" (seq.++ " " (seq.++ "P" (seq.++ "o" (seq.++ "w" (seq.++ "e" (seq.++ "r" (seq.++ "l" (seq.++ "e" (seq.++ "v" (seq.++ "e" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "g" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (str.to_re (seq.++ "W" (seq.++ "o" (seq.++ "r" (seq.++ "l" (seq.++ "d" (seq.++ " " (seq.++ "o" (seq.++ "f" (seq.++ " " (seq.++ "W" (seq.++ "a" (seq.++ "r" (seq.++ "c" (seq.++ "r" (seq.++ "a" (seq.++ "f" (seq.++ "t" (seq.++ " " (seq.++ "P" (seq.++ "o" (seq.++ "w" (seq.++ "e" (seq.++ "r" (seq.++ "l" (seq.++ "e" (seq.++ "v" (seq.++ "e" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "g" ""))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
