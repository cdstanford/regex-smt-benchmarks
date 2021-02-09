;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([^_][\w\d\@\-]+(?:s\'|\'[a-zA-Z]{1,2})?(?:\,)?(?: [\w\d\@\-]+(?:s\'|\'[a-zA-Z]{1,2})?(?:\,)?)*(?:\.|\!|\?){0,3}[^\s_])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x4\u00C4\'B \u00AA\'c,??\u00D2"
(define-fun Witness1 () String (seq.++ "\x04" (seq.++ "\xc4" (seq.++ "'" (seq.++ "B" (seq.++ " " (seq.++ "\xaa" (seq.++ "'" (seq.++ "c" (seq.++ "," (seq.++ "?" (seq.++ "?" (seq.++ "\xd2" "")))))))))))))
;witness2: "\u00BA\u00C9Zs\', 7\u00BA\u00BAs\', \u00AA-\u00DC\'ix,?\u007F"
(define-fun Witness2 () String (seq.++ "\xba" (seq.++ "\xc9" (seq.++ "Z" (seq.++ "s" (seq.++ "'" (seq.++ "," (seq.++ " " (seq.++ "7" (seq.++ "\xba" (seq.++ "\xba" (seq.++ "s" (seq.++ "'" (seq.++ "," (seq.++ " " (seq.++ "\xaa" (seq.++ "-" (seq.++ "\xdc" (seq.++ "'" (seq.++ "i" (seq.++ "x" (seq.++ "," (seq.++ "?" (seq.++ "\x7f" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "\x00" "^") (re.range "`" "\xff"))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.opt (re.union (str.to_re (seq.++ "s" (seq.++ "'" ""))) (re.++ (re.range "'" "'") ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.opt (re.range "," ","))(re.++ (re.* (re.++ (re.range " " " ")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.opt (re.union (str.to_re (seq.++ "s" (seq.++ "'" ""))) (re.++ (re.range "'" "'") ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.opt (re.range "," ","))))))(re.++ ((_ re.loop 0 3) (re.union (re.range "!" "!")(re.union (re.range "." ".") (re.range "?" "?")))) (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "^")(re.union (re.range "`" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
