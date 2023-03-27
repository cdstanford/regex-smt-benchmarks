;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = clipvn
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "clipvn"
(define-fun Witness1 () String (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "v" (str.++ "n" "")))))))
;witness2: "\u00F3\u00B9clipvn\u00E99W"
(define-fun Witness2 () String (str.++ "\u{f3}" (str.++ "\u{b9}" (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "v" (str.++ "n" (str.++ "\u{e9}" (str.++ "9" (str.++ "W" ""))))))))))))

(assert (= regexA (str.to_re (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "v" (str.++ "n" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
