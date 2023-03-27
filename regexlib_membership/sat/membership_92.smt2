;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:Error|Warning|Exception)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Exception\u00A0\u00B6"
(define-fun Witness1 () String (str.++ "E" (str.++ "x" (str.++ "c" (str.++ "e" (str.++ "p" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "\u{a0}" (str.++ "\u{b6}" ""))))))))))))
;witness2: "Exception"
(define-fun Witness2 () String (str.++ "E" (str.++ "x" (str.++ "c" (str.++ "e" (str.++ "p" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" ""))))))))))

(assert (= regexA (re.union (str.to_re (str.++ "E" (str.++ "r" (str.++ "r" (str.++ "o" (str.++ "r" ""))))))(re.union (str.to_re (str.++ "W" (str.++ "a" (str.++ "r" (str.++ "n" (str.++ "i" (str.++ "n" (str.++ "g" "")))))))) (str.to_re (str.++ "E" (str.++ "x" (str.++ "c" (str.++ "e" (str.++ "p" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
