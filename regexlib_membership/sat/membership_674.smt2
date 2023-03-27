;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Z][\w\d\.\-]+)(?:(?:\+)([\w\d\.\-]+))?@([A-Z0-9][\w\.-]*[A-Z0-9]\.[A-Z][A-Z\.]*[A-Z])
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xE\x16I\x13\u009DBl+7@R99.TM\u00AD"
(define-fun Witness1 () String (str.++ "\u{0e}" (str.++ "\u{16}" (str.++ "I" (str.++ "\u{13}" (str.++ "\u{9d}" (str.++ "B" (str.++ "l" (str.++ "+" (str.++ "7" (str.++ "@" (str.++ "R" (str.++ "9" (str.++ "9" (str.++ "." (str.++ "T" (str.++ "M" (str.++ "\u{ad}" ""))))))))))))))))))
;witness2: "K_\u00B5\u00B5+H\u00AAZ.@UR.V.ZJ"
(define-fun Witness2 () String (str.++ "K" (str.++ "_" (str.++ "\u{b5}" (str.++ "\u{b5}" (str.++ "+" (str.++ "H" (str.++ "\u{aa}" (str.++ "Z" (str.++ "." (str.++ "@" (str.++ "U" (str.++ "R" (str.++ "." (str.++ "V" (str.++ "." (str.++ "Z" (str.++ "J" ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.range "A" "Z") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))(re.++ (re.opt (re.++ (re.range "+" "+") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))(re.++ (re.range "@" "@") (re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ (re.range "." ".")(re.++ (re.range "A" "Z")(re.++ (re.* (re.union (re.range "." ".") (re.range "A" "Z"))) (re.range "A" "Z"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
