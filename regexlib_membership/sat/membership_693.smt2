;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[\w\"\ '\#\* \=\',\.\\\(\)\/\-\$\{\}\[\]\|\*\?\+\^\&\:\%\;\!]+>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<\u00B5>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "\xb5" (seq.++ ">" ""))))
;witness2: "\u00FD\u00C3<\u00AA>"
(define-fun Witness2 () String (seq.++ "\xfd" (seq.++ "\xc3" (seq.++ "<" (seq.++ "\xaa" (seq.++ ">" ""))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range " " ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "_")(re.union (re.range "a" "}")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
