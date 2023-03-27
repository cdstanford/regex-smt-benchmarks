;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (a|b|c).(a.b)*.b+.c
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00B0c8a\u00C5b\u00B4bb\u00D1c"
(define-fun Witness1 () String (str.++ "\u{b0}" (str.++ "c" (str.++ "8" (str.++ "a" (str.++ "\u{c5}" (str.++ "b" (str.++ "\u{b4}" (str.++ "b" (str.++ "b" (str.++ "\u{d1}" (str.++ "c" ""))))))))))))
;witness2: "6\u00E3Cb\u0095ibb\u008Cc"
(define-fun Witness2 () String (str.++ "6" (str.++ "\u{e3}" (str.++ "C" (str.++ "b" (str.++ "\u{95}" (str.++ "i" (str.++ "b" (str.++ "b" (str.++ "\u{8c}" (str.++ "c" "")))))))))))

(assert (= regexA (re.++ (re.range "a" "c")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.* (re.++ (re.range "a" "a")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.range "b" "b"))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.+ (re.range "b" "b"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.range "c" "c")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
