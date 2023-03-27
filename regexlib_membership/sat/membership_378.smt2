;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = World of Warcraft Powerleveling
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "World of Warcraft Powerleveling\x13\u00CA"
(define-fun Witness1 () String (str.++ "W" (str.++ "o" (str.++ "r" (str.++ "l" (str.++ "d" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "W" (str.++ "a" (str.++ "r" (str.++ "c" (str.++ "r" (str.++ "a" (str.++ "f" (str.++ "t" (str.++ " " (str.++ "P" (str.++ "o" (str.++ "w" (str.++ "e" (str.++ "r" (str.++ "l" (str.++ "e" (str.++ "v" (str.++ "e" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "g" (str.++ "\u{13}" (str.++ "\u{ca}" ""))))))))))))))))))))))))))))))))))
;witness2: "\x5\u00885World of Warcraft Powerleveling"
(define-fun Witness2 () String (str.++ "\u{05}" (str.++ "\u{88}" (str.++ "5" (str.++ "W" (str.++ "o" (str.++ "r" (str.++ "l" (str.++ "d" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "W" (str.++ "a" (str.++ "r" (str.++ "c" (str.++ "r" (str.++ "a" (str.++ "f" (str.++ "t" (str.++ " " (str.++ "P" (str.++ "o" (str.++ "w" (str.++ "e" (str.++ "r" (str.++ "l" (str.++ "e" (str.++ "v" (str.++ "e" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "g" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (str.to_re (str.++ "W" (str.++ "o" (str.++ "r" (str.++ "l" (str.++ "d" (str.++ " " (str.++ "o" (str.++ "f" (str.++ " " (str.++ "W" (str.++ "a" (str.++ "r" (str.++ "c" (str.++ "r" (str.++ "a" (str.++ "f" (str.++ "t" (str.++ " " (str.++ "P" (str.++ "o" (str.++ "w" (str.++ "e" (str.++ "r" (str.++ "l" (str.++ "e" (str.++ "v" (str.++ "e" (str.++ "l" (str.++ "i" (str.++ "n" (str.++ "g" ""))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
