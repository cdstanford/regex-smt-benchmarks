;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ("((\\.)|[^\\"])*")
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00CF\u00BE,\"\u00C8\x16\""
(define-fun Witness1 () String (seq.++ "\xcf" (seq.++ "\xbe" (seq.++ "," (seq.++ "\x22" (seq.++ "\xc8" (seq.++ "\x16" (seq.++ "\x22" ""))))))))
;witness2: "\"\u00D0\"1"
(define-fun Witness2 () String (seq.++ "\x22" (seq.++ "\xd0" (seq.++ "\x22" (seq.++ "1" "")))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.range "\x00" "!")(re.union (re.range "#" "[") (re.range "]" "\xff"))))) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
