;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \p{Sm}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u008E]\u00B1"
(define-fun Witness1 () String (seq.++ "\x8e" (seq.++ "]" (seq.++ "\xb1" ""))))
;witness2: "="
(define-fun Witness2 () String (seq.++ "=" ""))

(assert (= regexA (re.union (re.range "+" "+")(re.union (re.range "<" ">")(re.union (re.range "|" "|")(re.union (re.range "~" "~")(re.union (re.range "\xac" "\xac")(re.union (re.range "\xb1" "\xb1")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
