;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Za-z]:|\\{2}([-\w]+|((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\\(([^"*/:?|<>\\,;[\]+=.\x00-\x20]|\.[.\x20]*[^"*/:?|<>\\,;[\]+=.\x00-\x20])([^"*/:?|<>\\,;[\]+=\x00-\x1F]*[^"*/:?|<>\\,;[\]+=\x00-\x20])?))\\([^"*/:?|<>\\.\x00-\x20]([^"*/:?|<>\\\x00-\x1F]*[^"*/:?|<>\\.\x00-\x20])?\\)*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "x:\,\"
(define-fun Witness1 () String (seq.++ "x" (seq.++ ":" (seq.++ "\x5c" (seq.++ "," (seq.++ "\x5c" ""))))))
;witness2: "a:\)\\u00F2\u00F4\"
(define-fun Witness2 () String (seq.++ "a" (seq.++ ":" (seq.++ "\x5c" (seq.++ ")" (seq.++ "\x5c" (seq.++ "\xf2" (seq.++ "\xf4" (seq.++ "\x5c" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ ((_ re.loop 2 2) (re.range "\x5c" "\x5c"))(re.++ (re.union (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.range "." "."))) (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))))(re.++ (re.range "\x5c" "\x5c") (re.++ (re.union (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\xff"))))))) (re.++ (re.range "." ".")(re.++ (re.* (re.union (re.range " " " ") (re.range "." "."))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\xff")))))))))) (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\xff")))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\xff"))))))))))))))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.* (re.++ (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))(re.++ (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))) (re.range "\x5c" "\x5c")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
