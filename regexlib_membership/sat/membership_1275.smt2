;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(LDAP://([\w]+/)?(CN=['\w\s\-\&amp;]+,)*(OU=['\w\s\-\&amp;]+,)*(DC=['\w\s\-\&amp;]+[,]*)+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "LDAP://CN=__,DC=\u0085\u0085DC=\u00EE\u0085"
(define-fun Witness1 () String (seq.++ "L" (seq.++ "D" (seq.++ "A" (seq.++ "P" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "C" (seq.++ "N" (seq.++ "=" (seq.++ "_" (seq.++ "_" (seq.++ "," (seq.++ "D" (seq.++ "C" (seq.++ "=" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "D" (seq.++ "C" (seq.++ "=" (seq.++ "\xee" (seq.++ "\x85" ""))))))))))))))))))))))))
;witness2: "LDAP://DC=\u00B5;DC=v,,"
(define-fun Witness2 () String (seq.++ "L" (seq.++ "D" (seq.++ "A" (seq.++ "P" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "D" (seq.++ "C" (seq.++ "=" (seq.++ "\xb5" (seq.++ ";" (seq.++ "D" (seq.++ "C" (seq.++ "=" (seq.++ "v" (seq.++ "," (seq.++ "," "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "L" (seq.++ "D" (seq.++ "A" (seq.++ "P" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (re.range "/" "/")))(re.++ (re.* (re.++ (str.to_re (seq.++ "C" (seq.++ "N" (seq.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.range "," ","))))(re.++ (re.* (re.++ (str.to_re (seq.++ "O" (seq.++ "U" (seq.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.range "," ",")))) (re.+ (re.++ (str.to_re (seq.++ "D" (seq.++ "C" (seq.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.* (re.range "," ","))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
