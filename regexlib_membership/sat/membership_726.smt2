;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2\u0080WY3fBl\u00CE9@xk.Q6.4F.3E.6y.Jw"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "\x80" (seq.++ "W" (seq.++ "Y" (seq.++ "3" (seq.++ "f" (seq.++ "B" (seq.++ "l" (seq.++ "\xce" (seq.++ "9" (seq.++ "@" (seq.++ "x" (seq.++ "k" (seq.++ "." (seq.++ "Q" (seq.++ "6" (seq.++ "." (seq.++ "4" (seq.++ "F" (seq.++ "." (seq.++ "3" (seq.++ "E" (seq.++ "." (seq.++ "6" (seq.++ "y" (seq.++ "." (seq.++ "J" (seq.++ "w" "")))))))))))))))))))))))))))))
;witness2: "\x0ha@d9j.QPvQg"
(define-fun Witness2 () String (seq.++ "\x00" (seq.++ "h" (seq.++ "a" (seq.++ "@" (seq.++ "d" (seq.++ "9" (seq.++ "j" (seq.++ "." (seq.++ "Q" (seq.++ "P" (seq.++ "v" (seq.++ "Q" (seq.++ "g" ""))))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.range "." "."))))) ((_ re.loop 2 9) (re.union (re.range "A" "Z") (re.range "a" "z"))))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
