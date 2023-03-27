;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = foo
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "foo\u0080}\u0098\u009C\u00F0"
(define-fun Witness1 () String (str.++ "f" (str.++ "o" (str.++ "o" (str.++ "\u{80}" (str.++ "}" (str.++ "\u{98}" (str.++ "\u{9c}" (str.++ "\u{f0}" "")))))))))
;witness2: "\u00FC\x1Cfoo\x6"
(define-fun Witness2 () String (str.++ "\u{fc}" (str.++ "\u{1c}" (str.++ "f" (str.++ "o" (str.++ "o" (str.++ "\u{06}" "")))))))

(assert (= regexA (str.to_re (str.++ "f" (str.++ "o" (str.++ "o" ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
