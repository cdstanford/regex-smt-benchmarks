;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(LDAP://([\w]+/)?(CN=['\w\s\-\&amp;]+,)*(OU=['\w\s\-\&amp;]+,)*(DC=['\w\s\-\&amp;]+[,]*)+)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "LDAP://CN=__,DC=\u0085\u0085DC=\u00EE\u0085"
(define-fun Witness1 () String (str.++ "L" (str.++ "D" (str.++ "A" (str.++ "P" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "C" (str.++ "N" (str.++ "=" (str.++ "_" (str.++ "_" (str.++ "," (str.++ "D" (str.++ "C" (str.++ "=" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "D" (str.++ "C" (str.++ "=" (str.++ "\u{ee}" (str.++ "\u{85}" ""))))))))))))))))))))))))
;witness2: "LDAP://DC=\u00B5;DC=v,,"
(define-fun Witness2 () String (str.++ "L" (str.++ "D" (str.++ "A" (str.++ "P" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "D" (str.++ "C" (str.++ "=" (str.++ "\u{b5}" (str.++ ";" (str.++ "D" (str.++ "C" (str.++ "=" (str.++ "v" (str.++ "," (str.++ "," "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (str.++ "L" (str.++ "D" (str.++ "A" (str.++ "P" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.range "/" "/")))(re.++ (re.* (re.++ (str.to_re (str.++ "C" (str.++ "N" (str.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))) (re.range "," ","))))(re.++ (re.* (re.++ (str.to_re (str.++ "O" (str.++ "U" (str.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))) (re.range "," ",")))) (re.+ (re.++ (str.to_re (str.++ "D" (str.++ "C" (str.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))) (re.* (re.range "," ","))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
