;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<assembly>[\w\.]+)(,\s?Version=(?<version>\d+\.\d+\.\d+\.\d+))?(,\s?Culture=(?<culture>\w+))?(,\s?PublicKeyToken=(?<token>\w+))?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "7,Culture=_\u00F2\u00C8,\u00A0PublicKeyToken=m"
(define-fun Witness1 () String (str.++ "7" (str.++ "," (str.++ "C" (str.++ "u" (str.++ "l" (str.++ "t" (str.++ "u" (str.++ "r" (str.++ "e" (str.++ "=" (str.++ "_" (str.++ "\u{f2}" (str.++ "\u{c8}" (str.++ "," (str.++ "\u{a0}" (str.++ "P" (str.++ "u" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "K" (str.++ "e" (str.++ "y" (str.++ "T" (str.++ "o" (str.++ "k" (str.++ "e" (str.++ "n" (str.++ "=" (str.++ "m" ""))))))))))))))))))))))))))))))))
;witness2: ".,Version=1.248948.8.2"
(define-fun Witness2 () String (str.++ "." (str.++ "," (str.++ "V" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "=" (str.++ "1" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "." (str.++ "2" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "V" (str.++ "e" (str.++ "r" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "=" ""))))))))) (re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "C" (str.++ "u" (str.++ "l" (str.++ "t" (str.++ "u" (str.++ "r" (str.++ "e" (str.++ "=" ""))))))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))(re.++ (re.opt (re.++ (re.range "," ",")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (str.to_re (str.++ "P" (str.++ "u" (str.++ "b" (str.++ "l" (str.++ "i" (str.++ "c" (str.++ "K" (str.++ "e" (str.++ "y" (str.++ "T" (str.++ "o" (str.++ "k" (str.++ "e" (str.++ "n" (str.++ "=" "")))))))))))))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
