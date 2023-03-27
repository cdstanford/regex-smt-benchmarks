;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^jdbc:db2://((?:(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))|(?:(?:(?:(?:[A-Z|a-z])(?:[\w|-]){0,61}(?:[\w]?[.]))*)(?:(?:[A-Z|a-z])(?:[\w|-]){0,61}(?:[\w]?)))):([0-9]{1,5})/([0-9|A-Z|a-z|_|#|$]{1,16})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "jdbc:db2://|\u00B5\u00D1H:89/rYG|1#$#g"
(define-fun Witness1 () String (str.++ "j" (str.++ "d" (str.++ "b" (str.++ "c" (str.++ ":" (str.++ "d" (str.++ "b" (str.++ "2" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "|" (str.++ "\u{b5}" (str.++ "\u{d1}" (str.++ "H" (str.++ ":" (str.++ "8" (str.++ "9" (str.++ "/" (str.++ "r" (str.++ "Y" (str.++ "G" (str.++ "|" (str.++ "1" (str.++ "#" (str.++ "$" (str.++ "#" (str.++ "g" "")))))))))))))))))))))))))))))
;witness2: "jdbc:db2://188\u00CC69J237\u00DA255:89/|"
(define-fun Witness2 () String (str.++ "j" (str.++ "d" (str.++ "b" (str.++ "c" (str.++ ":" (str.++ "d" (str.++ "b" (str.++ "2" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "\u{cc}" (str.++ "6" (str.++ "9" (str.++ "J" (str.++ "2" (str.++ "3" (str.++ "7" (str.++ "\u{da}" (str.++ "2" (str.++ "5" (str.++ "5" (str.++ ":" (str.++ "8" (str.++ "9" (str.++ "/" (str.++ "|" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "j" (str.++ "d" (str.++ "b" (str.++ "c" (str.++ ":" (str.++ "d" (str.++ "b" (str.++ "2" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))))))(re.++ (re.union (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))) (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))) (re.++ (re.* (re.++ (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|")))(re.++ ((_ re.loop 0 61) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))(re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.range "." ".")))))(re.++ (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|")))(re.++ ((_ re.loop 0 61) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))) (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 5) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 1 16) (re.union (re.range "#" "$")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "|" "|"))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
