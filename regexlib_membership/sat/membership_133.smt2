;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<protocol>(http|ftp|https|ftps):\/\/)?(?<site>[\w\-_\.]+\.(?<tld>([0-9]{1,3})|([a-zA-Z]{2,3})|(aero|coop|info|museum|name))+(?<port>:[0-9]+)?\/?)((?<resource>[\w\-\.,@^%:/~\+#]*[\w\-\@^%/~\+#])(?<queryString>(\?[a-zA-Z0-9\[\]\-\._+%\$#\~',]*=[a-zA-Z0-9\[\]\-\._+%\$#\~',]*)+(&[a-zA-Z0-9\[\]\-\._+%\$#\~',]*=[a-zA-Z0-9\[\]\-\._+%\$#\~',]*)*)?)?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+\x19\u00BA.aeroaeroo\u00B5?=+&=&=2"
(define-fun Witness1 () String (str.++ "+" (str.++ "\u{19}" (str.++ "\u{ba}" (str.++ "." (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" (str.++ "o" (str.++ "\u{b5}" (str.++ "?" (str.++ "=" (str.++ "+" (str.++ "&" (str.++ "=" (str.++ "&" (str.++ "=" (str.++ "2" "")))))))))))))))))))))))
;witness2: "\u009Fhttp://k\u00B5..infocoopaero:2\x12\u00BF7c\u0095"
(define-fun Witness2 () String (str.++ "\u{9f}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "k" (str.++ "\u{b5}" (str.++ "." (str.++ "." (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" (str.++ "c" (str.++ "o" (str.++ "o" (str.++ "p" (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" (str.++ ":" (str.++ "2" (str.++ "\u{12}" (str.++ "\u{bf}" (str.++ "7" (str.++ "c" (str.++ "\u{95}" ""))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.union (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" ""))))(re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" "")))))) (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" (str.++ "s" "")))))))) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))))(re.++ (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union ((_ re.loop 1 3) (re.range "0" "9"))(re.union ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.union (str.to_re (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" "")))))(re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "o" (str.++ "p" "")))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" "")))))(re.union (str.to_re (str.++ "m" (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "u" (str.++ "m" ""))))))) (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" ""))))))))))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9")))) (re.opt (re.range "/" "/")))))) (re.opt (re.++ (re.++ (re.* (re.union (re.range "#" "#")(re.union (re.range "%" "%")(re.union (re.range "+" ":")(re.union (re.range "@" "Z")(re.union (re.range "^" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))) (re.union (re.range "#" "#")(re.union (re.range "%" "%")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))) (re.opt (re.++ (re.+ (re.++ (re.range "?" "?")(re.++ (re.* (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))(re.++ (re.range "=" "=") (re.* (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~")))))))))))))) (re.* (re.++ (re.range "&" "&")(re.++ (re.* (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))(re.++ (re.range "=" "=") (re.* (re.union (re.range "#" "%")(re.union (re.range "'" "'")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "[")(re.union (re.range "]" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
