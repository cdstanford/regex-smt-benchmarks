;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = runescape
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Wrunescape\u00A7\u00CF\u00E5"
(define-fun Witness1 () String (str.++ "W" (str.++ "r" (str.++ "u" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ "c" (str.++ "a" (str.++ "p" (str.++ "e" (str.++ "\u{a7}" (str.++ "\u{cf}" (str.++ "\u{e5}" ""))))))))))))))
;witness2: "4\u007FIrunescape"
(define-fun Witness2 () String (str.++ "4" (str.++ "\u{7f}" (str.++ "I" (str.++ "r" (str.++ "u" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ "c" (str.++ "a" (str.++ "p" (str.++ "e" "")))))))))))))

(assert (= regexA (str.to_re (str.++ "r" (str.++ "u" (str.++ "n" (str.++ "e" (str.++ "s" (str.++ "c" (str.++ "a" (str.++ "p" (str.++ "e" ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
