;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([a-z0-9])+([\w.-]{1})?)+([^\W_]{1}))+@((([a-z0-9])+([\w-]{1})?)+([^\W_]{1}))+\.[a-z]{2,3}(\.[a-z]{2,4})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "d8341zn2x8\u00BA8@d\u00D5.arg.alt"
(define-fun Witness1 () String (seq.++ "d" (seq.++ "8" (seq.++ "3" (seq.++ "4" (seq.++ "1" (seq.++ "z" (seq.++ "n" (seq.++ "2" (seq.++ "x" (seq.++ "8" (seq.++ "\xba" (seq.++ "8" (seq.++ "@" (seq.++ "d" (seq.++ "\xd5" (seq.++ "." (seq.++ "a" (seq.++ "r" (seq.++ "g" (seq.++ "." (seq.++ "a" (seq.++ "l" (seq.++ "t" ""))))))))))))))))))))))))
;witness2: "0Ef98d3\u00E9hn7.z\u00BA6@18w7\u00E66lz7\u00D00o\u00AA.xa.qwza"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "E" (seq.++ "f" (seq.++ "9" (seq.++ "8" (seq.++ "d" (seq.++ "3" (seq.++ "\xe9" (seq.++ "h" (seq.++ "n" (seq.++ "7" (seq.++ "." (seq.++ "z" (seq.++ "\xba" (seq.++ "6" (seq.++ "@" (seq.++ "1" (seq.++ "8" (seq.++ "w" (seq.++ "7" (seq.++ "\xe6" (seq.++ "6" (seq.++ "l" (seq.++ "z" (seq.++ "7" (seq.++ "\xd0" (seq.++ "0" (seq.++ "o" (seq.++ "\xaa" (seq.++ "." (seq.++ "x" (seq.++ "a" (seq.++ "." (seq.++ "q" (seq.++ "w" (seq.++ "z" (seq.++ "a" ""))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.range "a" "z"))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 4) (re.range "a" "z")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
