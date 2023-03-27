;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([a-z0-9])+([\w.-]{1})?)+([^\W_]{1}))+@((([a-z0-9])+([\w-]{1})?)+([^\W_]{1}))+\.[a-z]{2,3}(\.[a-z]{2,4})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "d8341zn2x8\u00BA8@d\u00D5.arg.alt"
(define-fun Witness1 () String (str.++ "d" (str.++ "8" (str.++ "3" (str.++ "4" (str.++ "1" (str.++ "z" (str.++ "n" (str.++ "2" (str.++ "x" (str.++ "8" (str.++ "\u{ba}" (str.++ "8" (str.++ "@" (str.++ "d" (str.++ "\u{d5}" (str.++ "." (str.++ "a" (str.++ "r" (str.++ "g" (str.++ "." (str.++ "a" (str.++ "l" (str.++ "t" ""))))))))))))))))))))))))
;witness2: "0Ef98d3\u00E9hn7.z\u00BA6@18w7\u00E66lz7\u00D00o\u00AA.xa.qwza"
(define-fun Witness2 () String (str.++ "0" (str.++ "E" (str.++ "f" (str.++ "9" (str.++ "8" (str.++ "d" (str.++ "3" (str.++ "\u{e9}" (str.++ "h" (str.++ "n" (str.++ "7" (str.++ "." (str.++ "z" (str.++ "\u{ba}" (str.++ "6" (str.++ "@" (str.++ "1" (str.++ "8" (str.++ "w" (str.++ "7" (str.++ "\u{e6}" (str.++ "6" (str.++ "l" (str.++ "z" (str.++ "7" (str.++ "\u{d0}" (str.++ "0" (str.++ "o" (str.++ "\u{aa}" (str.++ "." (str.++ "x" (str.++ "a" (str.++ "." (str.++ "q" (str.++ "w" (str.++ "z" (str.++ "a" ""))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.range "a" "z"))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 4) (re.range "a" "z")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
