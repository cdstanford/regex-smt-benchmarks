;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^jdbc:db2://((?:(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))|(?:(?:(?:(?:[A-Z|a-z])(?:[\w|-]){0,61}(?:[\w]?[.]))*)(?:(?:[A-Z|a-z])(?:[\w|-]){0,61}(?:[\w]?)))):([0-9]{1,5})/([0-9|A-Z|a-z|_|#|$]{1,16})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "jdbc:db2://|\u00B5\u00D1H:89/rYG|1#$#g"
(define-fun Witness1 () String (seq.++ "j" (seq.++ "d" (seq.++ "b" (seq.++ "c" (seq.++ ":" (seq.++ "d" (seq.++ "b" (seq.++ "2" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "|" (seq.++ "\xb5" (seq.++ "\xd1" (seq.++ "H" (seq.++ ":" (seq.++ "8" (seq.++ "9" (seq.++ "/" (seq.++ "r" (seq.++ "Y" (seq.++ "G" (seq.++ "|" (seq.++ "1" (seq.++ "#" (seq.++ "$" (seq.++ "#" (seq.++ "g" "")))))))))))))))))))))))))))))
;witness2: "jdbc:db2://188\u00CC69J237\u00DA255:89/|"
(define-fun Witness2 () String (seq.++ "j" (seq.++ "d" (seq.++ "b" (seq.++ "c" (seq.++ ":" (seq.++ "d" (seq.++ "b" (seq.++ "2" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "\xcc" (seq.++ "6" (seq.++ "9" (seq.++ "J" (seq.++ "2" (seq.++ "3" (seq.++ "7" (seq.++ "\xda" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ ":" (seq.++ "8" (seq.++ "9" (seq.++ "/" (seq.++ "|" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "j" (seq.++ "d" (seq.++ "b" (seq.++ "c" (seq.++ ":" (seq.++ "d" (seq.++ "b" (seq.++ "2" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))))))(re.++ (re.union (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))) (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))) (re.++ (re.* (re.++ (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|")))(re.++ ((_ re.loop 0 61) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.range "." ".")))))(re.++ (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|")))(re.++ ((_ re.loop 0 61) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))) (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 5) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 1 16) (re.union (re.range "#" "$")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "|" "|"))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
