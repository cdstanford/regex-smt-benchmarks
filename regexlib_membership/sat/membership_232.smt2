;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \$(\d)*\d
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E7\u0082$58\u009B\u00BDY\u00C9A\u0094\u00D8\u0093"
(define-fun Witness1 () String (seq.++ "\xe7" (seq.++ "\x82" (seq.++ "$" (seq.++ "5" (seq.++ "8" (seq.++ "\x9b" (seq.++ "\xbd" (seq.++ "Y" (seq.++ "\xc9" (seq.++ "A" (seq.++ "\x94" (seq.++ "\xd8" (seq.++ "\x93" ""))))))))))))))
;witness2: "x\u00F5$758777922687"
(define-fun Witness2 () String (seq.++ "x" (seq.++ "\xf5" (seq.++ "$" (seq.++ "7" (seq.++ "5" (seq.++ "8" (seq.++ "7" (seq.++ "7" (seq.++ "7" (seq.++ "9" (seq.++ "2" (seq.++ "2" (seq.++ "6" (seq.++ "8" (seq.++ "7" ""))))))))))))))))

(assert (= regexA (re.++ (re.range "$" "$")(re.++ (re.* (re.range "0" "9")) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
