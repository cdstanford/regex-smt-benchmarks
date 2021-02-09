;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w ]*.*))+\.((html|HTML)|(htm|HTM))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\\u00C6$\\u00EE\u00C68.HTML"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\xc6" (seq.++ "$" (seq.++ "\x5c" (seq.++ "\xee" (seq.++ "\xc6" (seq.++ "8" (seq.++ "." (seq.++ "H" (seq.++ "T" (seq.++ "M" (seq.++ "L" ""))))))))))))))
;witness2: "R:\\u00AAv\\u00AA.HTML"
(define-fun Witness2 () String (seq.++ "R" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\xaa" (seq.++ "v" (seq.++ "\x5c" (seq.++ "\xaa" (seq.++ "." (seq.++ "H" (seq.++ "T" (seq.++ "M" (seq.++ "L" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ (re.++ ((_ re.loop 2 2) (re.range "\x5c" "\x5c")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.opt (re.range "$" "$"))))(re.++ (re.+ (re.++ (re.range "\x5c" "\x5c") (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))(re.++ (re.range "." ".")(re.++ (re.union (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "m" (seq.++ "l" ""))))) (str.to_re (seq.++ "H" (seq.++ "T" (seq.++ "M" (seq.++ "L" "")))))) (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "m" "")))) (str.to_re (seq.++ "H" (seq.++ "T" (seq.++ "M" "")))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
