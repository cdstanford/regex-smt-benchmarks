;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "2\u0080WY3fBl\u00CE9@xk.Q6.4F.3E.6y.Jw"
(define-fun Witness1 () String (str.++ "2" (str.++ "\u{80}" (str.++ "W" (str.++ "Y" (str.++ "3" (str.++ "f" (str.++ "B" (str.++ "l" (str.++ "\u{ce}" (str.++ "9" (str.++ "@" (str.++ "x" (str.++ "k" (str.++ "." (str.++ "Q" (str.++ "6" (str.++ "." (str.++ "4" (str.++ "F" (str.++ "." (str.++ "3" (str.++ "E" (str.++ "." (str.++ "6" (str.++ "y" (str.++ "." (str.++ "J" (str.++ "w" "")))))))))))))))))))))))))))))
;witness2: "\x0ha@d9j.QPvQg"
(define-fun Witness2 () String (str.++ "\u{00}" (str.++ "h" (str.++ "a" (str.++ "@" (str.++ "d" (str.++ "9" (str.++ "j" (str.++ "." (str.++ "Q" (str.++ "P" (str.++ "v" (str.++ "Q" (str.++ "g" ""))))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.range "." "."))))) ((_ re.loop 2 9) (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
