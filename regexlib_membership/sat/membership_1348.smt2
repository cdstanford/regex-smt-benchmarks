;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((CN=['\w\d\s\-\&amp;]+,)+(OU=['\w\d\s\-\&amp;]+,)*(DC=['\w\d\s\-\&amp;]+[,]*){2,})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "CN=x,OU=\u0085\xA\u00F9,DC=\u00DB,,DC=;"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "N" (seq.++ "=" (seq.++ "x" (seq.++ "," (seq.++ "O" (seq.++ "U" (seq.++ "=" (seq.++ "\x85" (seq.++ "\x0a" (seq.++ "\xf9" (seq.++ "," (seq.++ "D" (seq.++ "C" (seq.++ "=" (seq.++ "\xdb" (seq.++ "," (seq.++ "," (seq.++ "D" (seq.++ "C" (seq.++ "=" (seq.++ ";" "")))))))))))))))))))))))
;witness2: "CN=\u00A0,OU=\u0085,OU=\u00F3,OU=\xA,OU=\u00BA\u00A0,OU=\u00E6,DC=\u00EC,,DC=Ez"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "N" (seq.++ "=" (seq.++ "\xa0" (seq.++ "," (seq.++ "O" (seq.++ "U" (seq.++ "=" (seq.++ "\x85" (seq.++ "," (seq.++ "O" (seq.++ "U" (seq.++ "=" (seq.++ "\xf3" (seq.++ "," (seq.++ "O" (seq.++ "U" (seq.++ "=" (seq.++ "\x0a" (seq.++ "," (seq.++ "O" (seq.++ "U" (seq.++ "=" (seq.++ "\xba" (seq.++ "\xa0" (seq.++ "," (seq.++ "O" (seq.++ "U" (seq.++ "=" (seq.++ "\xe6" (seq.++ "," (seq.++ "D" (seq.++ "C" (seq.++ "=" (seq.++ "\xec" (seq.++ "," (seq.++ "," (seq.++ "D" (seq.++ "C" (seq.++ "=" (seq.++ "E" (seq.++ "z" "")))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.++ (str.to_re (seq.++ "C" (seq.++ "N" (seq.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.range "," ","))))(re.++ (re.* (re.++ (str.to_re (seq.++ "O" (seq.++ "U" (seq.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.range "," ",")))) (re.++ ((_ re.loop 2 2) (re.++ (str.to_re (seq.++ "D" (seq.++ "C" (seq.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.* (re.range "," ","))))) (re.* (re.++ (str.to_re (seq.++ "D" (seq.++ "C" (seq.++ "=" ""))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))) (re.* (re.range "," ",")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
