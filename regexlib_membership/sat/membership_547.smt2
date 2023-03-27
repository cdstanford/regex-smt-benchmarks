;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([^_][\w\d\@\-]+(?:s\'|\'[a-zA-Z]{1,2})?(?:\,)?(?: [\w\d\@\-]+(?:s\'|\'[a-zA-Z]{1,2})?(?:\,)?)*(?:\.|\!|\?){0,3}[^\s_])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x4\u00C4\'B \u00AA\'c,??\u00D2"
(define-fun Witness1 () String (str.++ "\u{04}" (str.++ "\u{c4}" (str.++ "'" (str.++ "B" (str.++ " " (str.++ "\u{aa}" (str.++ "'" (str.++ "c" (str.++ "," (str.++ "?" (str.++ "?" (str.++ "\u{d2}" "")))))))))))))
;witness2: "\u00BA\u00C9Zs\', 7\u00BA\u00BAs\', \u00AA-\u00DC\'ix,?\u007F"
(define-fun Witness2 () String (str.++ "\u{ba}" (str.++ "\u{c9}" (str.++ "Z" (str.++ "s" (str.++ "'" (str.++ "," (str.++ " " (str.++ "7" (str.++ "\u{ba}" (str.++ "\u{ba}" (str.++ "s" (str.++ "'" (str.++ "," (str.++ " " (str.++ "\u{aa}" (str.++ "-" (str.++ "\u{dc}" (str.++ "'" (str.++ "i" (str.++ "x" (str.++ "," (str.++ "?" (str.++ "\u{7f}" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "\u{00}" "^") (re.range "`" "\u{ff}"))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.opt (re.union (str.to_re (str.++ "s" (str.++ "'" ""))) (re.++ (re.range "'" "'") ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.opt (re.range "," ","))(re.++ (re.* (re.++ (re.range " " " ")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.opt (re.union (str.to_re (str.++ "s" (str.++ "'" ""))) (re.++ (re.range "'" "'") ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.opt (re.range "," ","))))))(re.++ ((_ re.loop 0 3) (re.union (re.range "!" "!")(re.union (re.range "." ".") (re.range "?" "?")))) (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "^")(re.union (re.range "`" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
