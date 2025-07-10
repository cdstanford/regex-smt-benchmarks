;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<type>(\w+(\.?\w+)+))\s*,\s*(?<assembly>[\w\.]+)(,\s?Version=(?<version>\d+\.\d+\.\d+\.\d+))?(,\s?Culture=(?<culture>\w+))?(,\s?PublicKeyToken=(?<token>\w+))?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Q.m\u00CB\u00BA.c.e8\u00D0\u00BA.\u00F6 ,\u00A0\u0085\xBv,\u0085PublicKeyToken=\u00AA"
(define-fun Witness1 () String (str.++ "Q" (str.++ "." (str.++ "m" (str.++ "\u{cb}" (str.++ "\u{ba}" (str.++ "." (str.++ "c" (str.++ "." (str.++ "e" (str.++ "8" (str.++ "\u{d0}" (str.++ "\u{ba}" (str.++ "." (str.++ "\u{f6}" (str.++ " " (str.++ "," (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "\u{0b}" (str.++ "v" (str.++ "," (str.++ "\u{85}" (str.++ "P" (str.++ "u" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "K" (str.++ "e" (str.++ "y" (str.++ "T" (str.++ "o" (str.++ "k" (str.++ "e" (str.++ "n" (str.++ "=" (str.++ "\u{aa}" "")))))))))))))))))))))))))))))))))))))))
;witness2: "\u00DEZf ,\u00DD"
(define-fun Witness2 () String (str.++ "\u{de}" (str.++ "Z" (str.++ "f" (str.++ " " (str.++ "," (str.++ "\u{dd}" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.+ (re.++ (re.opt (re.range "." ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "," ",")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "V" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "=" ""))))))))) (re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "C" (str.++ "u" (str.++ "l" (str.++ "t" (str.++ "u" (str.++ "r" (str.++ "e" (str.++ "=" ""))))))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "P" (str.++ "u" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "K" (str.++ "e" (str.++ "y" (str.++ "T" (str.++ "o" (str.++ "k" (str.++ "e" (str.++ "n" (str.++ "=" "")))))))))))))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
