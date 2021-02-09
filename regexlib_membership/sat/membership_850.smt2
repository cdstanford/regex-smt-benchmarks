;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \w*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E4\u0098\u0097\u0090\u00D0\u00B5"
(define-fun Witness1 () String (seq.++ "\xe4" (seq.++ "\x98" (seq.++ "\x97" (seq.++ "\x90" (seq.++ "\xd0" (seq.++ "\xb5" "")))))))
;witness2: "\u00F5M"
(define-fun Witness2 () String (seq.++ "\xf5" (seq.++ "M" "")))

(assert (= regexA (re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
