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

;witness1: "\u00B2q\u00B3\u00E5xB\u009A\u00A6\'\u0086vclipvn"
(define-fun Witness1 () String (str.++ "\u{b2}" (str.++ "q" (str.++ "\u{b3}" (str.++ "\u{e5}" (str.++ "x" (str.++ "B" (str.++ "\u{9a}" (str.++ "\u{a6}" (str.++ "'" (str.++ "\u{86}" (str.++ "v" (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "v" (str.++ "n" ""))))))))))))))))))
;witness2: "clipvn\"
(define-fun Witness2 () String (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "v" (str.++ "n" (str.++ "\u{5c}" ""))))))))

(assert (= regexA (str.to_re (str.++ "c" (str.++ "l" (str.++ "i" (str.++ "p" (str.++ "v" (str.++ "n" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
