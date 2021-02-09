;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (a|b|c).(a.b)*.b+.c
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B0c8a\u00C5b\u00B4bb\u00D1c"
(define-fun Witness1 () String (seq.++ "\xb0" (seq.++ "c" (seq.++ "8" (seq.++ "a" (seq.++ "\xc5" (seq.++ "b" (seq.++ "\xb4" (seq.++ "b" (seq.++ "b" (seq.++ "\xd1" (seq.++ "c" ""))))))))))))
;witness2: "6\u00E3Cb\u0095ibb\u008Cc"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "\xe3" (seq.++ "C" (seq.++ "b" (seq.++ "\x95" (seq.++ "i" (seq.++ "b" (seq.++ "b" (seq.++ "\x8c" (seq.++ "c" "")))))))))))

(assert (= regexA (re.++ (re.range "a" "c")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.* (re.++ (re.range "a" "a")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "b" "b"))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.+ (re.range "b" "b"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "c" "c")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
