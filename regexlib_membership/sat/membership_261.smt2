;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\(]{1,}[^)]*[)]{1,}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(\u00E2l\xD)))"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "\xe2" (seq.++ "l" (seq.++ "\x0d" (seq.++ ")" (seq.++ ")" (seq.++ ")" ""))))))))
;witness2: "(\u00E3Z))\u00E4+"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "\xe3" (seq.++ "Z" (seq.++ ")" (seq.++ ")" (seq.++ "\xe4" (seq.++ "+" ""))))))))

(assert (= regexA (re.++ (re.+ (re.range "(" "("))(re.++ (re.* (re.union (re.range "\x00" "(") (re.range "*" "\xff"))) (re.+ (re.range ")" ")"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
