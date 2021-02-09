;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(.{0,}(([a-zA-Z][^a-zA-Z])|([^a-zA-Z][a-zA-Z])).{4,})|(.{1,}(([a-zA-Z][^a-zA-Z])|([^a-zA-Z][a-zA-Z])).{3,})|(.{2,}(([a-zA-Z][^a-zA-Z])|([^a-zA-Z][a-zA-Z])).{2,})|(.{3,}(([a-zA-Z][^a-zA-Z])|([^a-zA-Z][a-zA-Z])).{1,})|(.{4,}(([a-zA-Z][^a-zA-Z])|([^a-zA-Z][a-zA-Z])).{0,})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00C1X\x7\u00F8\u00CD\u00C8\x1B\u00BC\u00C1\u00E7\u007F"
(define-fun Witness1 () String (seq.++ "\xc1" (seq.++ "X" (seq.++ "\x07" (seq.++ "\xf8" (seq.++ "\xcd" (seq.++ "\xc8" (seq.++ "\x1b" (seq.++ "\xbc" (seq.++ "\xc1" (seq.++ "\xe7" (seq.++ "\x7f" ""))))))))))))
;witness2: "C`}\u00DA\u00B3\u00BF,\u0086\u00F8"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "`" (seq.++ "}" (seq.++ "\xda" (seq.++ "\xb3" (seq.++ "\xbf" (seq.++ "," (seq.++ "\x86" (seq.++ "\xf8" ""))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff")))) (re.++ (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff"))) (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.++ ((_ re.loop 4 4) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))(re.union (re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff")))) (re.++ (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff"))) (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.++ ((_ re.loop 3 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))(re.union (re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff")))) (re.++ (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff"))) (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.++ ((_ re.loop 2 2) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))(re.union (re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff")))) (re.++ (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff"))) (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.++ (re.++ (re.++ ((_ re.loop 4 4) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff")))) (re.++ (re.union (re.range "\x00" "@")(re.union (re.range "[" "`") (re.range "{" "\xff"))) (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
