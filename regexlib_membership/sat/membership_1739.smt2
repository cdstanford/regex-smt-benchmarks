;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((?<strElement>(^[A-Z0-9-;=]*:))(?<strValue>(.*)))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8E:"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "E" (seq.++ ":" ""))))
;witness2: ":\u00BCc"
(define-fun Witness2 () String (seq.++ ":" (seq.++ "\xbc" (seq.++ "c" ""))))

(assert (= regexA (re.++ (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=") (re.range "A" "Z")))))) (re.range ":" ":"))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
