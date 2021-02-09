;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x10a\u0094\u00E7&W"
(define-fun Witness1 () String (seq.++ "\x10" (seq.++ "a" (seq.++ "\x94" (seq.++ "\xe7" (seq.++ "&" (seq.++ "W" "")))))))
;witness2: "&\u00F3\u00D0["
(define-fun Witness2 () String (seq.++ "&" (seq.++ "\xf3" (seq.++ "\xd0" (seq.++ "[" "")))))

(assert (= regexA (re.range "&" "&")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
