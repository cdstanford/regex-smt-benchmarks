;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:(?:\.\./)|/)?(?:\w(?:[\w`~!$=;\-\+\.\^\(\)\|\{\}\[\]]|(?:%\d\d))*\w?)?(?:/\w(?:[\w`~!$=;\-\+\.\^\(\)\|\{\}\[\]]|(?:%\d\d))*\w?)*(?:\?[^#]+)?(?:#[a-z0-9]\w*)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "//\u00D0%46\u00C0\u00AA%78d\u00D6/5\u00AA%89{Vc%890?\xD\u00A4#a\u00B5"
(define-fun Witness1 () String (seq.++ "/" (seq.++ "/" (seq.++ "\xd0" (seq.++ "%" (seq.++ "4" (seq.++ "6" (seq.++ "\xc0" (seq.++ "\xaa" (seq.++ "%" (seq.++ "7" (seq.++ "8" (seq.++ "d" (seq.++ "\xd6" (seq.++ "/" (seq.++ "5" (seq.++ "\xaa" (seq.++ "%" (seq.++ "8" (seq.++ "9" (seq.++ "{" (seq.++ "V" (seq.++ "c" (seq.++ "%" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "?" (seq.++ "\x0d" (seq.++ "\xa4" (seq.++ "#" (seq.++ "a" (seq.++ "\xb5" "")))))))))))))))))))))))))))))))))
;witness2: "\u00CA/5%22\u00D4\u00DE?\u00C5#z"
(define-fun Witness2 () String (seq.++ "\xca" (seq.++ "/" (seq.++ "5" (seq.++ "%" (seq.++ "2" (seq.++ "2" (seq.++ "\xd4" (seq.++ "\xde" (seq.++ "?" (seq.++ "\xc5" (seq.++ "#" (seq.++ "z" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (seq.++ "." (seq.++ "." (seq.++ "/" "")))) (re.range "/" "/")))(re.++ (re.opt (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "(" ")")(re.union (re.range "+" "+")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "]" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))) (re.++ (re.range "%" "%")(re.++ (re.range "0" "9") (re.range "0" "9"))))) (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))(re.++ (re.* (re.++ (re.range "/" "/")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "(" ")")(re.union (re.range "+" "+")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "]" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))) (re.++ (re.range "%" "%")(re.++ (re.range "0" "9") (re.range "0" "9"))))) (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.opt (re.++ (re.range "?" "?") (re.+ (re.union (re.range "\x00" "\x22") (re.range "$" "\xff")))))(re.++ (re.opt (re.++ (re.range "#" "#")(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
