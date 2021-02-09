;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (https?://)?((?:(\w+-)*\w+)\.)+(?:com|org|net|edu|gov|biz|info|name|museum|[a-z]{2})(\/?\w?-?=?_?\??&?)+[\.]?[a-z0-9\?=&_\-%#]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E79\u00E3-\u00BA_\u00F1.biz-&&&/_#"
(define-fun Witness1 () String (seq.++ "\xe7" (seq.++ "9" (seq.++ "\xe3" (seq.++ "-" (seq.++ "\xba" (seq.++ "_" (seq.++ "\xf1" (seq.++ "." (seq.++ "b" (seq.++ "i" (seq.++ "z" (seq.++ "-" (seq.++ "&" (seq.++ "&" (seq.++ "&" (seq.++ "/" (seq.++ "_" (seq.++ "#" "")))))))))))))))))))
;witness2: "https://\u00BA-7-\u00AAz-\u00BAy\u00C8-0-f-\u00BA-\u00AA0\u00D89\u00AA7\u00B5-\u00C7-\u00E8\u00CB-\u00FB\u00DB-9l.6.9.2-\u00E9\u00FE9.9\u00FA\u00FBE\u00BAl\u00F8-q9-\u00BA-\u00EF\u00F6ut\u00B5.lv-5\u00AA\u00C8.y-3.\u00F0.museum/6_\u00F9M"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xba" (seq.++ "-" (seq.++ "7" (seq.++ "-" (seq.++ "\xaa" (seq.++ "z" (seq.++ "-" (seq.++ "\xba" (seq.++ "y" (seq.++ "\xc8" (seq.++ "-" (seq.++ "0" (seq.++ "-" (seq.++ "f" (seq.++ "-" (seq.++ "\xba" (seq.++ "-" (seq.++ "\xaa" (seq.++ "0" (seq.++ "\xd8" (seq.++ "9" (seq.++ "\xaa" (seq.++ "7" (seq.++ "\xb5" (seq.++ "-" (seq.++ "\xc7" (seq.++ "-" (seq.++ "\xe8" (seq.++ "\xcb" (seq.++ "-" (seq.++ "\xfb" (seq.++ "\xdb" (seq.++ "-" (seq.++ "9" (seq.++ "l" (seq.++ "." (seq.++ "6" (seq.++ "." (seq.++ "9" (seq.++ "." (seq.++ "2" (seq.++ "-" (seq.++ "\xe9" (seq.++ "\xfe" (seq.++ "9" (seq.++ "." (seq.++ "9" (seq.++ "\xfa" (seq.++ "\xfb" (seq.++ "E" (seq.++ "\xba" (seq.++ "l" (seq.++ "\xf8" (seq.++ "-" (seq.++ "q" (seq.++ "9" (seq.++ "-" (seq.++ "\xba" (seq.++ "-" (seq.++ "\xef" (seq.++ "\xf6" (seq.++ "u" (seq.++ "t" (seq.++ "\xb5" (seq.++ "." (seq.++ "l" (seq.++ "v" (seq.++ "-" (seq.++ "5" (seq.++ "\xaa" (seq.++ "\xc8" (seq.++ "." (seq.++ "y" (seq.++ "-" (seq.++ "3" (seq.++ "." (seq.++ "\xf0" (seq.++ "." (seq.++ "m" (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "u" (seq.++ "m" (seq.++ "/" (seq.++ "6" (seq.++ "_" (seq.++ "\xf9" (seq.++ "M" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.++ (re.opt (re.range "s" "s")) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))(re.++ (re.+ (re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.range "-" "-")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.range "." "."))))(re.++ (re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "m" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "r" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "e" (seq.++ "d" (seq.++ "u" ""))))(re.union (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "v" ""))))(re.union (str.to_re (seq.++ "b" (seq.++ "i" (seq.++ "z" ""))))(re.union (str.to_re (seq.++ "i" (seq.++ "n" (seq.++ "f" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" "")))))(re.union (str.to_re (seq.++ "m" (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "u" (seq.++ "m" ""))))))) ((_ re.loop 2 2) (re.range "a" "z")))))))))))(re.++ (re.+ (re.++ (re.opt (re.range "/" "/"))(re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "=" "="))(re.++ (re.opt (re.range "_" "_"))(re.++ (re.opt (re.range "?" "?")) (re.opt (re.range "&" "&")))))))))(re.++ (re.opt (re.range "." ".")) (re.* (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
