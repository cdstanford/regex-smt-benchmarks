;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = wwwwwwww
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00C7wwwwwwwwW\u0093#"
(define-fun Witness1 () String (seq.++ "\xc7" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "W" (seq.++ "\x93" (seq.++ "#" "")))))))))))))
;witness2: "\u009B\u0091wwwwwwww\u00F3"
(define-fun Witness2 () String (seq.++ "\x9b" (seq.++ "\x91" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "\xf3" ""))))))))))))

(assert (= regexA (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "w" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
