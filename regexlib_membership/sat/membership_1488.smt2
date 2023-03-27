;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6@y\u00D2\u00BA\u00B5Xg\u00BA\u00D8-4.13.92.Muyu"
(define-fun Witness1 () String (str.++ "6" (str.++ "@" (str.++ "y" (str.++ "\u{d2}" (str.++ "\u{ba}" (str.++ "\u{b5}" (str.++ "X" (str.++ "g" (str.++ "\u{ba}" (str.++ "\u{d8}" (str.++ "-" (str.++ "4" (str.++ "." (str.++ "1" (str.++ "3" (str.++ "." (str.++ "9" (str.++ "2" (str.++ "." (str.++ "M" (str.++ "u" (str.++ "y" (str.++ "u" ""))))))))))))))))))))))))
;witness2: "19A\u00AA9\u00B5\u00B5\u00AA\u00AA\u00E5412z@z8Z19.NC"
(define-fun Witness2 () String (str.++ "1" (str.++ "9" (str.++ "A" (str.++ "\u{aa}" (str.++ "9" (str.++ "\u{b5}" (str.++ "\u{b5}" (str.++ "\u{aa}" (str.++ "\u{aa}" (str.++ "\u{e5}" (str.++ "4" (str.++ "1" (str.++ "2" (str.++ "z" (str.++ "@" (str.++ "z" (str.++ "8" (str.++ "Z" (str.++ "1" (str.++ "9" (str.++ "." (str.++ "N" (str.++ "C" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))) ((_ re.loop 2 9) (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
