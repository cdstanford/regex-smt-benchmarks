;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = foo
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "foo\u0080}\u0098\u009C\u00F0"
(define-fun Witness1 () String (seq.++ "f" (seq.++ "o" (seq.++ "o" (seq.++ "\x80" (seq.++ "}" (seq.++ "\x98" (seq.++ "\x9c" (seq.++ "\xf0" "")))))))))
;witness2: "\u00FC\x1Cfoo\x6"
(define-fun Witness2 () String (seq.++ "\xfc" (seq.++ "\x1c" (seq.++ "f" (seq.++ "o" (seq.++ "o" (seq.++ "\x06" "")))))))

(assert (= regexA (str.to_re (seq.++ "f" (seq.++ "o" (seq.++ "o" ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
