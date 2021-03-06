;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "(\\.|[^"])*"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ",\"\"^"
(define-fun Witness1 () String (seq.++ "," (seq.++ "\x22" (seq.++ "\x22" (seq.++ "^" "")))))
;witness2: "\u00EE1\x15,\"\s\\u00C0\2\1i\""
(define-fun Witness2 () String (seq.++ "\xee" (seq.++ "1" (seq.++ "\x15" (seq.++ "," (seq.++ "\x22" (seq.++ "\x5c" (seq.++ "s" (seq.++ "\x5c" (seq.++ "\xc0" (seq.++ "\x5c" (seq.++ "2" (seq.++ "\x5c" (seq.++ "1" (seq.++ "i" (seq.++ "\x22" ""))))))))))))))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.range "\x00" "!") (re.range "#" "\xff")))) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
