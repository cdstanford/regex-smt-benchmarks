;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Za-z]:|\\{2}([-\w]+|((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\\(([^"*/:?|<>\\,;[\]+=.\x00-\x20]|\.[.\x20]*[^"*/:?|<>\\,;[\]+=.\x00-\x20])([^"*/:?|<>\\,;[\]+=\x00-\x1F]*[^"*/:?|<>\\,;[\]+=\x00-\x20])?))\\([^"*/:?|<>\\.\x00-\x20]([^"*/:?|<>\\\x00-\x1F]*[^"*/:?|<>\\.\x00-\x20])?\\)*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "x:\,\"
(define-fun Witness1 () String (str.++ "x" (str.++ ":" (str.++ "\u{5c}" (str.++ "," (str.++ "\u{5c}" ""))))))
;witness2: "a:\)\\u00F2\u00F4\"
(define-fun Witness2 () String (str.++ "a" (str.++ ":" (str.++ "\u{5c}" (str.++ ")" (str.++ "\u{5c}" (str.++ "\u{f2}" (str.++ "\u{f4}" (str.++ "\u{5c}" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ ((_ re.loop 2 2) (re.range "\u{5c}" "\u{5c}"))(re.++ (re.union (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.range "." "."))) (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9"))))))))(re.++ (re.range "\u{5c}" "\u{5c}") (re.++ (re.union (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\u{ff}"))))))) (re.++ (re.range "." ".")(re.++ (re.* (re.union (re.range " " " ") (re.range "." "."))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\u{ff}")))))))))) (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\u{ff}")))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\u{ff}"))))))))))))))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.* (re.++ (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}")))))))))(re.++ (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}")))))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}"))))))))))) (re.range "\u{5c}" "\u{5c}")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
