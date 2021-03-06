;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<type>(\w+(\.?\w+)+))\s*,\s*(?<assembly>[\w\.]+)(,\s?Version=(?<version>\d+\.\d+\.\d+\.\d+))?(,\s?Culture=(?<culture>\w+))?(,\s?PublicKeyToken=(?<token>\w+))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Q.m\u00CB\u00BA.c.e8\u00D0\u00BA.\u00F6 ,\u00A0\u0085\xBv,\u0085PublicKeyToken=\u00AA"
(define-fun Witness1 () String (seq.++ "Q" (seq.++ "." (seq.++ "m" (seq.++ "\xcb" (seq.++ "\xba" (seq.++ "." (seq.++ "c" (seq.++ "." (seq.++ "e" (seq.++ "8" (seq.++ "\xd0" (seq.++ "\xba" (seq.++ "." (seq.++ "\xf6" (seq.++ " " (seq.++ "," (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\x0b" (seq.++ "v" (seq.++ "," (seq.++ "\x85" (seq.++ "P" (seq.++ "u" (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "c" (seq.++ "K" (seq.++ "e" (seq.++ "y" (seq.++ "T" (seq.++ "o" (seq.++ "k" (seq.++ "e" (seq.++ "n" (seq.++ "=" (seq.++ "\xaa" "")))))))))))))))))))))))))))))))))))))))
;witness2: "\u00DEZf ,\u00DD"
(define-fun Witness2 () String (seq.++ "\xde" (seq.++ "Z" (seq.++ "f" (seq.++ " " (seq.++ "," (seq.++ "\xdd" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.+ (re.++ (re.opt (re.range "." ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "," ",")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "V" (seq.++ "e" (seq.++ "r" (seq.++ "s" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "=" ""))))))))) (re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "C" (seq.++ "u" (seq.++ "l" (seq.++ "t" (seq.++ "u" (seq.++ "r" (seq.++ "e" (seq.++ "=" ""))))))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (str.to_re (seq.++ "P" (seq.++ "u" (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "c" (seq.++ "K" (seq.++ "e" (seq.++ "y" (seq.++ "T" (seq.++ "o" (seq.++ "k" (seq.++ "e" (seq.++ "n" (seq.++ "=" "")))))))))))))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
