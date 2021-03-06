;---
; using 8-bit bit-vectors as characters
; check intersection nonemptiness of .Net regexes
; regexA = ^([A-Z]{2}|[a-z]{2} \d{2} [A-Z]{1,2}|[a-z]{1,2} \d{1,4})?([A-Z]{3}|[a-z]{3} \d{1,4})?\z
; regexB = ^((\w|\d|\-|\.)+)@{1}(((\w|\d|\-){1,67})|((\w|\d|\-)+\.(\w|\d|\-){1,67}))\.((([a-z]|[A-Z]|\d){2,4})(\.([a-z]|A|Z|\d){2})?)\z
;---
(set-info :status unsat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const regexB (RegEx String))
(declare-const x String)

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union ((_ re.loop 2 2) (re.range "A" "Z"))(re.union (re.++ ((_ re.loop 2 2) (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 1 2) (re.range "A" "Z")))))) (re.++ ((_ re.loop 1 2) (re.range "a" "z"))(re.++ (re.range " " " ") ((_ re.loop 1 4) (re.range "0" "9")))))))(re.++ (re.opt (re.union ((_ re.loop 3 3) (re.range "A" "Z")) (re.++ ((_ re.loop 3 3) (re.range "a" "z"))(re.++ (re.range " " " ") ((_ re.loop 1 4) (re.range "0" "9")))))) (str.to_re ""))))))

(assert (= regexB (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union ((_ re.loop 1 67) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "." ".") ((_ re.loop 1 67) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.range "." ".")(re.++ (re.++ ((_ re.loop 2 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "A")(re.union (re.range "Z" "Z") (re.range "a" "z")))))))) (str.to_re "")))))))))

;check that the intersection is nonempty, contains some x
(assert (str.in_re x regexA))
(assert (str.in_re x regexB))
(check-sat)
