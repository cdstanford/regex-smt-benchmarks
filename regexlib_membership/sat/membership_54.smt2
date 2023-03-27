;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:(?:\.\./)|/)?(?:\w(?:[\w`~!$=;\-\+\.\^\(\)\|\{\}\[\]]|(?:%\d\d))*\w?)?(?:/\w(?:[\w`~!$=;\-\+\.\^\(\)\|\{\}\[\]]|(?:%\d\d))*\w?)*(?:\?[^#]+)?(?:#[a-z0-9]\w*)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "//\u00D0%46\u00C0\u00AA%78d\u00D6/5\u00AA%89{Vc%890?\xD\u00A4#a\u00B5"
(define-fun Witness1 () String (str.++ "/" (str.++ "/" (str.++ "\u{d0}" (str.++ "%" (str.++ "4" (str.++ "6" (str.++ "\u{c0}" (str.++ "\u{aa}" (str.++ "%" (str.++ "7" (str.++ "8" (str.++ "d" (str.++ "\u{d6}" (str.++ "/" (str.++ "5" (str.++ "\u{aa}" (str.++ "%" (str.++ "8" (str.++ "9" (str.++ "{" (str.++ "V" (str.++ "c" (str.++ "%" (str.++ "8" (str.++ "9" (str.++ "0" (str.++ "?" (str.++ "\u{0d}" (str.++ "\u{a4}" (str.++ "#" (str.++ "a" (str.++ "\u{b5}" "")))))))))))))))))))))))))))))))))
;witness2: "\u00CA/5%22\u00D4\u00DE?\u00C5#z"
(define-fun Witness2 () String (str.++ "\u{ca}" (str.++ "/" (str.++ "5" (str.++ "%" (str.++ "2" (str.++ "2" (str.++ "\u{d4}" (str.++ "\u{de}" (str.++ "?" (str.++ "\u{c5}" (str.++ "#" (str.++ "z" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (str.to_re (str.++ "." (str.++ "." (str.++ "/" "")))) (re.range "/" "/")))(re.++ (re.opt (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))(re.++ (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "(" ")")(re.union (re.range "+" "+")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "]" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))) (re.++ (re.range "%" "%")(re.++ (re.range "0" "9") (re.range "0" "9"))))) (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))(re.++ (re.* (re.++ (re.range "/" "/")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))(re.++ (re.* (re.union (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "(" ")")(re.union (re.range "+" "+")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "[")(re.union (re.range "]" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))) (re.++ (re.range "%" "%")(re.++ (re.range "0" "9") (re.range "0" "9"))))) (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))(re.++ (re.opt (re.++ (re.range "?" "?") (re.+ (re.union (re.range "\u{00}" "\u{22}") (re.range "$" "\u{ff}")))))(re.++ (re.opt (re.++ (re.range "#" "#")(re.++ (re.union (re.range "0" "9") (re.range "a" "z")) (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
