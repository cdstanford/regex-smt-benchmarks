;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([^,\n]+),([^,\n]+),([^@]+)@([^\.]+)\.([^,\n]+)\n)+([^,\n]+),([^,\n]+),([^@]+)@([^\.]+)\.([^,\n]+)\n?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AC,\u00BD,xF@;!.\x2\xA\u008E,\x1D,?\x0\u00D0@T.^\xAF,\x17,(\x1CR\u00D7@\x3\u009D.8"
(define-fun Witness1 () String (seq.++ "\xac" (seq.++ "," (seq.++ "\xbd" (seq.++ "," (seq.++ "x" (seq.++ "F" (seq.++ "@" (seq.++ ";" (seq.++ "!" (seq.++ "." (seq.++ "\x02" (seq.++ "\x0a" (seq.++ "\x8e" (seq.++ "," (seq.++ "\x1d" (seq.++ "," (seq.++ "?" (seq.++ "\x00" (seq.++ "\xd0" (seq.++ "@" (seq.++ "T" (seq.++ "." (seq.++ "^" (seq.++ "\x0a" (seq.++ "F" (seq.++ "," (seq.++ "\x17" (seq.++ "," (seq.++ "(" (seq.++ "\x1c" (seq.++ "R" (seq.++ "\xd7" (seq.++ "@" (seq.++ "\x03" (seq.++ "\x9d" (seq.++ "." (seq.++ "8" ""))))))))))))))))))))))))))))))))))))))
;witness2: "\u00CET,\u00E9\u00C0\u00AA(\u00C2\u00D3\u00BC,w@e.\u00E6\u00EC\xAN\u00E5,\u00CA,\x12@\u00F7.\u008A\u00B3\xA=,U,\u00F9@q.\x12\u0082O\xA"
(define-fun Witness2 () String (seq.++ "\xce" (seq.++ "T" (seq.++ "," (seq.++ "\xe9" (seq.++ "\xc0" (seq.++ "\xaa" (seq.++ "(" (seq.++ "\xc2" (seq.++ "\xd3" (seq.++ "\xbc" (seq.++ "," (seq.++ "w" (seq.++ "@" (seq.++ "e" (seq.++ "." (seq.++ "\xe6" (seq.++ "\xec" (seq.++ "\x0a" (seq.++ "N" (seq.++ "\xe5" (seq.++ "," (seq.++ "\xca" (seq.++ "," (seq.++ "\x12" (seq.++ "@" (seq.++ "\xf7" (seq.++ "." (seq.++ "\x8a" (seq.++ "\xb3" (seq.++ "\x0a" (seq.++ "=" (seq.++ "," (seq.++ "U" (seq.++ "," (seq.++ "\xf9" (seq.++ "@" (seq.++ "q" (seq.++ "." (seq.++ "\x12" (seq.++ "\x82" (seq.++ "O" (seq.++ "\x0a" "")))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "+") (re.range "-" "\xff"))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "+") (re.range "-" "\xff"))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\x00" "?") (re.range "A" "\xff")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "\x00" "-") (re.range "/" "\xff")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "+") (re.range "-" "\xff")))) (re.range "\x0a" "\x0a")))))))))))(re.++ (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "+") (re.range "-" "\xff"))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "+") (re.range "-" "\xff"))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\x00" "?") (re.range "A" "\xff")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "\x00" "-") (re.range "/" "\xff")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "+") (re.range "-" "\xff"))))(re.++ (re.opt (re.range "\x0a" "\x0a")) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
