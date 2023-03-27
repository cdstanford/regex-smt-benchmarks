;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\\{2}[-\w]+\\(([^"*/:?|<>\\,;[\]+=.\x00-\x20]|\.[.\x20]*[^"*/:?|<>\\,;[\]+=.\x00-\x20])([^"*/:?|<>\\,;[\]+=\x00-\x1F]*[^"*/:?|<>\\,;[\]+=\x00-\x20])?)\\([^"*/:?|<>\\.\x00-\x20]([^"*/:?|<>\\\x00-\x1F]*[^"*/:?|<>\\.\x00-\x20])?\\)*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\\-\\u00E4g\u0087\\u00B7\\u00E6\"
(define-fun Witness1 () String (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "-" (str.++ "\u{5c}" (str.++ "\u{e4}" (str.++ "g" (str.++ "\u{87}" (str.++ "\u{5c}" (str.++ "\u{b7}" (str.++ "\u{5c}" (str.++ "\u{e6}" (str.++ "\u{5c}" "")))))))))))))
;witness2: "\\F\u00E9\\u00C89{\"
(define-fun Witness2 () String (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "F" (str.++ "\u{e9}" (str.++ "\u{5c}" (str.++ "\u{c8}" (str.++ "9" (str.++ "{" (str.++ "\u{5c}" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "\u{5c}" "\u{5c}"))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.++ (re.union (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\u{ff}"))))))) (re.++ (re.range "." ".")(re.++ (re.* (re.union (re.range " " " ") (re.range "." "."))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\u{ff}")))))))))) (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\u{ff}")))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "^" "{") (re.range "}" "\u{ff}"))))))))))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.* (re.++ (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}")))))))))(re.++ (re.opt (re.++ (re.* (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}")))))))))) (re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}"))))))))))) (re.range "\u{5c}" "\u{5c}")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
