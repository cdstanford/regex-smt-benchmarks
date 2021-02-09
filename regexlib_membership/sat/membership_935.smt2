;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-z]:((\\([-*\.*\w+\s+\d+]+)|(\w+)\\)+)(\w+.zip)|(\w+.ZIP))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "f:\u00AAc\\\u0085b2\x1Bzip"
(define-fun Witness1 () String (seq.++ "f" (seq.++ ":" (seq.++ "\xaa" (seq.++ "c" (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\x85" (seq.++ "b" (seq.++ "2" (seq.++ "\x1b" (seq.++ "z" (seq.++ "i" (seq.++ "p" ""))))))))))))))
;witness2: "n:\u00AA\u00E1\\\xB9I7\u00C4\\u00F6\u00B5izip"
(define-fun Witness2 () String (seq.++ "n" (seq.++ ":" (seq.++ "\xaa" (seq.++ "\xe1" (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\x0b" (seq.++ "9" (seq.++ "I" (seq.++ "7" (seq.++ "\xc4" (seq.++ "\x5c" (seq.++ "\xf6" (seq.++ "\xb5" (seq.++ "i" (seq.++ "z" (seq.++ "i" (seq.++ "p" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "A" "z")(re.++ (re.range ":" ":")(re.++ (re.+ (re.union (re.++ (re.range "\x5c" "\x5c") (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "*" "+")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.range "\x5c" "\x5c")))) (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "z" (seq.++ "i" (seq.++ "p" ""))))))))) (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "Z" (seq.++ "I" (seq.++ "P" ""))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
