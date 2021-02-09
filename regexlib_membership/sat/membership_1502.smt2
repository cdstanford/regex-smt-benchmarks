;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-\w`~!@#$%^&amp;*\(\)+={}|\[\]\\:&quot;;'&lt;&gt;?,.\/ ]*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B5IT"
(define-fun Witness1 () String (seq.++ "\xb5" (seq.++ "I" (seq.++ "T" ""))))
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
