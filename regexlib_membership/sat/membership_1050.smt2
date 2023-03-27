;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\w+=[^\s,=]+,)*(\w+=[^\s,=]+,?)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E3=\u00B5,92\u00D69=\u00FB\u00BB,W=K,09\u00BA=d\u00D6,"
(define-fun Witness1 () String (str.++ "\u{e3}" (str.++ "=" (str.++ "\u{b5}" (str.++ "," (str.++ "9" (str.++ "2" (str.++ "\u{d6}" (str.++ "9" (str.++ "=" (str.++ "\u{fb}" (str.++ "\u{bb}" (str.++ "," (str.++ "W" (str.++ "=" (str.++ "K" (str.++ "," (str.++ "0" (str.++ "9" (str.++ "\u{ba}" (str.++ "=" (str.++ "d" (str.++ "\u{d6}" (str.++ "," ""))))))))))))))))))))))))
;witness2: "\u00AA\u00C2w=\u00FB\u008A\x18,z=\u00B2d\xE\u008E"
(define-fun Witness2 () String (str.++ "\u{aa}" (str.++ "\u{c2}" (str.++ "w" (str.++ "=" (str.++ "\u{fb}" (str.++ "\u{8a}" (str.++ "\u{18}" (str.++ "," (str.++ "z" (str.++ "=" (str.++ "\u{b2}" (str.++ "d" (str.++ "\u{0e}" (str.++ "\u{8e}" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "=" "=")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "+")(re.union (re.range "-" "<")(re.union (re.range ">" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))) (re.range "," ",")))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "=" "=")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "+")(re.union (re.range "-" "<")(re.union (re.range ">" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))) (re.opt (re.range "," ",")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
