;---
; using 8-bit bit-vectors as characters
; check if regexA is not a subset of regexB
; regexA = ^((([A-Z]|[a-z]|[0-9])+[ ]+)|(([A-Z]|[a-z]|[0-9])+\-+)|(([A-Z]|[a-z]|[0-9])+\.+)|(([A-Z]|[a-z]|[0-9])+\++))*([A-Z]|[a-z]|[0-9])+@((\w+\-+)|(\w+\.))*\w{1,63}\.([A-Z]|[a-z]){2,6}\z
; regexB = ^((\w+((\-|\+|\.)\w+)*@\w+((\-|\.)\w+)*\.\w+((\-|\.)\w+)*)\s*[,]{0,1}\s*)+\z
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const regexB (RegEx String))
(declare-const x String)

;witness: "6@d.9.v\u00EF.k--Z.ih"
(define-fun Witness () String (seq.++ "6" (seq.++ "@" (seq.++ "d" (seq.++ "." (seq.++ "9" (seq.++ "." (seq.++ "v" (seq.++ "\xef" (seq.++ "." (seq.++ "k" (seq.++ "-" (seq.++ "-" (seq.++ "Z" (seq.++ "." (seq.++ "i" (seq.++ "h" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.+ (re.range " " " ")))(re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.+ (re.range "-" "-")))(re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.+ (re.range "." "."))) (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.+ (re.range "+" "+")))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "@" "@")(re.++ (re.* (re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.+ (re.range "-" "-"))) (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.range "." "."))))(re.++ ((_ re.loop 1 63) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))))

(assert (= regexB (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.union (re.range "+" "+") (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.range "-" ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.* (re.++ (re.range "-" ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "," ",")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))) (str.to_re "")))))

;(assert (not (re-subset regexA regexB)))
;check that the difference is nonempty, contains some x
(assert (str.in_re x regexA))
(assert (not (str.in_re x regexB)))
;check also the concrete witness
(assert (str.in_re Witness regexA))
(assert (not (str.in_re Witness regexB)))
(check-sat)
