;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((CN=['\w\d\s\-\&amp;]+,)+(OU=['\w\d\s\-\&amp;]+,)*(DC=['\w\d\s\-\&amp;]+[,]*){2,})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "CN=x,OU=\u0085\xA\u00F9,DC=\u00DB,,DC=;"
(define-fun Witness1 () String (str.++ "C" (str.++ "N" (str.++ "=" (str.++ "x" (str.++ "," (str.++ "O" (str.++ "U" (str.++ "=" (str.++ "\u{85}" (str.++ "\u{0a}" (str.++ "\u{f9}" (str.++ "," (str.++ "D" (str.++ "C" (str.++ "=" (str.++ "\u{db}" (str.++ "," (str.++ "," (str.++ "D" (str.++ "C" (str.++ "=" (str.++ ";" "")))))))))))))))))))))))
;witness2: "CN=\u00A0,OU=\u0085,OU=\u00F3,OU=\xA,OU=\u00BA\u00A0,OU=\u00E6,DC=\u00EC,,DC=Ez"
(define-fun Witness2 () String (str.++ "C" (str.++ "N" (str.++ "=" (str.++ "\u{a0}" (str.++ "," (str.++ "O" (str.++ "U" (str.++ "=" (str.++ "\u{85}" (str.++ "," (str.++ "O" (str.++ "U" (str.++ "=" (str.++ "\u{f3}" (str.++ "," (str.++ "O" (str.++ "U" (str.++ "=" (str.++ "\u{0a}" (str.++ "," (str.++ "O" (str.++ "U" (str.++ "=" (str.++ "\u{ba}" (str.++ "\u{a0}" (str.++ "," (str.++ "O" (str.++ "U" (str.++ "=" (str.++ "\u{e6}" (str.++ "," (str.++ "D" (str.++ "C" (str.++ "=" (str.++ "\u{ec}" (str.++ "," (str.++ "," (str.++ "D" (str.++ "C" (str.++ "=" (str.++ "E" (str.++ "z" "")))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.++ (str.to_re (str.++ "C" (str.++ "N" (str.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))) (re.range "," ","))))(re.++ (re.* (re.++ (str.to_re (str.++ "O" (str.++ "U" (str.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))) (re.range "," ",")))) (re.++ ((_ re.loop 2 2) (re.++ (str.to_re (str.++ "D" (str.++ "C" (str.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))) (re.* (re.range "," ","))))) (re.* (re.++ (str.to_re (str.++ "D" (str.++ "C" (str.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}")(re.union (re.range "\u{a0}" "\u{a0}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))) (re.* (re.range "," ",")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
