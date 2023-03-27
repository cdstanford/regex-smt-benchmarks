;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (([a-zA-Z]{3}[0-9]{3})|(\w{2}-\w{2}-\w{2})|([0-9]{2}-[a-zA-Z]{3}-[0-9]{1})|([0-9]{1}-[a-zA-Z]{3}-[0-9]{2})|([a-zA-Z]{1}-[0-9]{3}-[a-zA-Z]{2}))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ",\u00B2d\u00BB|6-BGy-98"
(define-fun Witness1 () String (str.++ "," (str.++ "\u{b2}" (str.++ "d" (str.++ "\u{bb}" (str.++ "|" (str.++ "6" (str.++ "-" (str.++ "B" (str.++ "G" (str.++ "y" (str.++ "-" (str.++ "9" (str.++ "8" ""))))))))))))))
;witness2: "\u00E2\u0095335-ykJ-80\u00DB"
(define-fun Witness2 () String (str.++ "\u{e2}" (str.++ "\u{95}" (str.++ "3" (str.++ "3" (str.++ "5" (str.++ "-" (str.++ "y" (str.++ "k" (str.++ "J" (str.++ "-" (str.++ "8" (str.++ "0" (str.++ "\u{db}" ""))))))))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "-" "-") (re.range "0" "9")))))(re.union (re.++ (re.range "0" "9")(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))))) (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
