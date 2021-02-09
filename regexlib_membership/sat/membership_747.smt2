;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\\{2}[-\w]+\\(([^"*/:?|<>\\,;[\]+=.\x00-\x20]|\.[.\x20]*[^"*/:?|<>\\,;[\]+=.\x00-\x20])([^"*/:?|<>\\,;[\]+=\x00-\x1F]*[^"*/:?|<>\\,;[\]+=\x00-\x20])?)\\([^"*/:?|<>\\.\x00-\x20]([^"*/:?|<>\\\x00-\x1F]*[^"*/:?|<>\\.\x00-\x20])?\\)*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\-\\u00E4g\u0087\\u00B7\\u00E6\"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "-" (seq.++ "\x5c" (seq.++ "\xe4" (seq.++ "g" (seq.++ "\x87" (seq.++ "\x5c" (seq.++ "\xb7" (seq.++ "\x5c" (seq.++ "\xe6" (seq.++ "\x5c" "")))))))))))))
;witness2: "\\F\u00E9\\u00C89{\"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "F" (seq.++ "\xe9" (seq.++ "\x5c" (seq.++ "\xc8" (seq.++ "9" (seq.++ "{" (seq.++ "\x5c" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "\x5c" "\x5c"))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.++ (re.union (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\xff"))))))) (re.++ (re.range "." ".")(re.++ (re.* (re.union (re.range " " " ") (re.range "." "."))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\xff")))))))))) (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\xff")))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\xff"))))))))))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.* (re.++ (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))(re.++ (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))) (re.range "\x5c" "\x5c")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
